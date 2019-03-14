class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  require 'will_paginate/array'

  def index
    @products = Product.paginate(page: params[:page], per_page: 108).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def shop
    if params[:category].present?
      ids = ProductCategory.where(category_id: params[:category]).pluck(:product_id)
      @products = Product.includes([:category, :sub_category, :product_images]).where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 30)
      @category = Category.where(id: params[:category]).first.name
    elsif params[:sub_category].present?
      ids = ProductSubCategory.where(sub_category_id: params[:sub_category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 30)
      @category = SubCategory.where(id: params[:sub_category]).first.name
    elsif params[:product_type].present?
      ids = ProductGroup.where(product_type_id: params[:product_type]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 30)
      @category = ProductType.where(id: params[:product_type]).first.name
    elsif params[:brand_id].present?
      ids = ProductBrand.where(brand_id: params[:brand_id]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 30)
      @category = Brand.where(id: params[:brand_id]).first.name
    elsif params[:search_product].present? && params[:search_product][:keyword].present? && params[:search_product][:category].present?
      ids = ProductCategory.where(category_id: params[:search_product][:category]).pluck(:product_id)
      products = Product.where("id IN (?)", ids)
      @products = products.where("name ILIKE ?", "%" + params[:search_product][:keyword] + "%").order(:price).paginate(:page => params[:page], :per_page => 16)
    elsif params[:search_product].present? && params[:search_product][:keyword].present?
      @products = []
      categories = Category.where("name ILIKE ?", "%" + params[:search_product][:keyword] + "%")
      categories.each do |category|
        @products << category.products
      end
      sub_categories = SubCategory.where("name ILIKE ?", "%" + params[:search_product][:keyword] + "%")
      sub_categories.each do |sub_category|
        @products << sub_category.products
      end
      product_type = ProductType.where("name ILIKE ?", "%" + params[:search_product][:keyword] + "%")
      product_type.each do |pro_type|
        @products << pro_type.products
      end
      @products << Product.where("name ILIKE ? OR description ILIKE ?", "%" + params[:search_product][:keyword] + "%", "%" + params[:search_product][:keyword] + "%")
      @products = @products.flatten.uniq
      @products = @products.sort_by { |product| [product.price] }
      @products = @products.paginate(:page => params[:page], :per_page => 30)

    elsif params[:search_product].present? && params[:search_product][:category].present?
      ids = ProductCategory.where(category_id: params[:search_product][:category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 30)
    else
      @products = Product.all.order(:price).paginate(:page => params[:page], :per_page => 30)
      if @products.present?
        @category = @products.last.category.name
      end
    end
    if @products.present?
      @sub_categories = @products.last.category.sub_categories
      @product_types = @products.last.sub_category.product_types if @products.last.sub_category.present?
    end
    render layout: "shop_application"
  end

  def sub_categories
    if params[:category].present?
      @category = Category.find(params[:category])
      @sub_categories = @category.sub_categories
      @products = @category.products.paginate( page: params[:page], per_page: 88)
    elsif params[:sub_category].present?
      @sub_category = SubCategory.includes(:product_types).find(params[:sub_category])
      @product_types = @sub_category.product_types
      @products = SubCategory.includes(:products).find(params[:sub_category]).products.paginate( page: params[:page], per_page: 88)
    else
      @product_type = ProductType.where(id:params[:product_type]).take
      @sub_category = @product_type.sub_category
      @parent_product_type = @product_type.parent_product_type
      @products = @product_type.products.paginate(page: params[:page], per_page: 88)
    end
    render layout: "shop_application", collection: @sub_categories
  end

  def product_types
    if params[:sub_category].present?
      @product_types = ProductType.where(sub_category_id: params[:sub_category]).limit(5)
    else
      redirect_to root_path
    end
    render layout: "shop_application"
  end

  def product
    @product = Product.includes([:product_images, :sub_category, :category]).find(params[:id])
    @related_products = @product.product_type.products
    if ShippingPrice.all.count > 0
      @product_shipping = ShippingPrice.first.price
    end
    if @product.sizes.present?
      @product_size = @product.sizes.first.name
    end
    if @product.colors.present?
      @product_colors = @product.colors.first.name
    end
    if current_user.present?
      recent_viewed = RecentView.where(user_id: current_user.id, product_id: params[:id])
      if recent_viewed.present?
      else
        RecentView.create(user_id: current_user.id, product_id: params[:id])
      end
    else
      session[:recent_views] ||= []
      if session[:recent_views].nil?
        session[:recent_views] << ""
        session[:recent_views] << params[:id].to_i
      else
        session[:recent_views] << params[:id].to_i
      end
      puts session[:recent_views]
    end
    render layout: "product_application"
  end

  def cart
    current_user.present? && current_user.orders.where(status: "pending").present? ? @order_items = current_user.orders.where(status: "pending").last.order_items : @order_items = []
    render layout: "cart_application"
  end

  def checkout
    if params[:value].present?
      @value = params[:value]
    end
    if current_user.present? && current_user.orders.present?
      @order_items = current_user.orders.where(status: "pending")
      if @order_items.present?
        @order_items = current_user.orders.where(status: "pending").last.order_items
      end
    end
    if current_user.present?
      if current_user.shipping.present?
        @shipping = current_user.shipping
      else
        @shipping = Shipping.new
      end
      render layout: "purchase_application"
    else
      redirect_to user_session_path
    end
  end

  def create_shipping
    if current_user.shipping.present?
      current_user.shipping.update_attributes(shipping_params)
    else
      shipping  = Shipping.create(shipping_params)
    end
    redirect_to checkout_path(value: "review_order")
  end

  def product_detail_modal
    @product= Product.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def add_card
    @order = current_user.orders
    total_price = 0
    if @order.present?
      @order = current_user.orders.where(status: "pending").last
      @order_items = @order.order_items
      @order_items.each do |o|
        product = Product.find(o.product_id)
        total_price += (product.price.to_f+o.shipping.to_i)*o.quantity.to_i
      end
    end
    $card = params[:card_info]
    begin
      if current_user.customer_id.nil?
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        customer = Stripe::Customer.create(email: current_user.email)
        current_user.customer_id = customer.id
        current_user.save
      else
        customer = Stripe::Customer.retrieve(current_user.customer_id)
      end
      token = generate_token
      id = customer.sources.create({source: token}).id
      customer.default_source = customer.sources.retrieve(id)
      user = current_user
      user.default_source = customer.default_source
      user.save
    rescue => e
      flash[:notice] = e.message
      redirect_to checkout_path(value: "payment")
      return
    end
    begin
      charge = Stripe::Charge.create({
                                         amount: total_price.ceil.to_i*100,
                                         currency: 'usd',
                                         description: "Order no #{user.orders.last.id}",
                                         customer: user.customer_id
                                     })
      order = current_user.orders.where(status: "pending").last
      order.status = "Paid"
      order.total_amount = total_price
      order.save
      url = "#{request.base_url}/my_order_details?id=#{order.id}"
      MessageMailer.order_email(user.email, user.full_name, user, url ,order).deliver_now
      MessageMailer.email_admin(user.full_name, user, url ,order).deliver_now
      session.delete(:shop_cart)
      flash[:notice] = 'Card charged successfully.'
      redirect_to checkout_path(value: "done")
      return
    rescue => e
      # Some other error; display an error message.
      flash[:notice] = e.message
      redirect_to checkout_path(value: "payment")
      return
    end
  end

  def generate_token
    Stripe::Token.create(
        card: {
            number: $card[:card],
            exp_month: $card[:month],
            exp_year: $card[:year],
            cvc: $card[:cvc]
        }
    ).id
  end
  def contact
    render layout: "contact_application"
  end

  def blog
    render layout: "blog_application"
  end

  def blog_show
    render layout: "blog_single_application"
  end

  def add_favorite
    @product_id = params[:product_id]
    if current_user.present?
      favorite = UserFavorite.where(user_id: current_user.id, product_id: params[:product_id])
      if favorite.present?
        # do nothing
      else
        UserFavorite.create(user_id: current_user.id, product_id: params[:product_id])
      end
    else
      # session.delete(:favorites)
      session[:favorites] ||= []
      if session[:favorites].nil?
        session[:favorites] << ""
        session[:favorites] << params[:product_id].to_i
      else
        session[:favorites] << params[:product_id].to_i
      end
    end
    respond_to do |format|
      format.js
    end
    render layout: "product_application"
  end

  def remove_favorite
    @product_id = params[:product_id]
    if current_user.present?
      favorite = UserFavorite.where(user_id: current_user.id, product_id: params[:product_id])
      if favorite.present?
        favorite.first.destroy
      end
    else
      session[:favorites].delete(params[:product_id].to_i)
    end
    respond_to do |format|
      format.js
    end
  end

  def my_favorites
    if current_user.present?
      favorites_ids = current_user.user_favorites.pluck(:product_id)
      @products = Product.where("id IN (?)", favorites_ids).paginate(:page => params[:page], :per_page => 10)
    else
      if !session[:favorites].nil?
        @products = Product.where("id IN (?)", session[:favorites]).paginate(:page => params[:page], :per_page => 10)
      else
        @products = Product.where("id IN (?)", []).paginate(:page => params[:page], :per_page => 10)
      end
    end
    render layout: "shop_application"
  end

  def add_to_cart
    if current_user.present?
      order = Order.where(user_id: current_user.id, status: "pending")
      if order.present?
        order_id = order.last.id
      else
        order = Order.create(user_id: current_user.id)
        order_id = order.id
      end
      order_item = OrderItem.create(product_id: params[:add_product_to_cart][:product_id], quantity: params[:add_product_to_cart][:quantity], order_id: order_id, size: params[:add_product_to_cart][:size], color: params[:add_product_to_cart][:color], shipping: params[:add_product_to_cart][:shipping])
    else
      # session.delete(:favorites)
      product_array = [params[:add_product_to_cart][:product_id], params[:add_product_to_cart][:quantity], params[:add_product_to_cart][:size], params[:add_product_to_cart][:color], params[:add_product_to_cart][:shipping]]
      session[:shop_cart] ||= []
      if session[:shop_cart].nil?
        session[:shop_cart] << ""
        session[:shop_cart] << product_array
      else
        session[:shop_cart] << product_array
      end
    end
    flash[:notice] = 'Product added to cart successfully!'
    redirect_to request.referer
  end

  def about_us
    render layout: "blog_single_application"
  end

  def contact_us
    render layout: "blog_single_application"
  end

  def terms_of_use
    render layout: "blog_single_application"
  end

  def discount_policy
    render layout: "blog_single_application"
  end

  def return
    render layout: "blog_single_application"
  end

  def privacy_policy
    render layout: "blog_single_application"
  end

  def shipping_help
    render layout: "blog_single_application"
  end

  def remove_item_from_cart
    session[:shop_cart].present? ? session[:shop_cart].delete_if {|product| product[0] == params[:product]} : OrderItem.find(params[:order_item].to_i).destroy
    redirect_to cart_path
  end

  def see_all
    @categories = Category.includes(sub_categories: :product_types).all.order(:see_all_order)
    render layout: "shop_application"
  end
  private

  def shipping_params
    params.require(:shipping).permit( :name, :cntry_name, :street_address_one, :street_address_two, :state, :city, :postal_code, :mobile, :user_id)
  end
end
