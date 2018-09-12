class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index

  end

  def shop
    if params[:category].present?
      ids = ProductCategory.where(category_id: params[:category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 15)
      @category = Category.where(id: params[:category]).first.name
    elsif params[:sub_category].present?
      ids = ProductSubCategory.where(sub_category_id: params[:sub_category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 15)
      @category = SubCategory.where(id: params[:sub_category]).first.name
    elsif params[:product_type].present?
      ids = ProductGroup.where(product_type_id: params[:product_type]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 15)
      @category = ProductType.where(id: params[:product_type]).first.name
    elsif params[:brand_id].present?
      ids = ProductBrand.where(brand_id: params[:brand_id]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 15)
      @category = Brand.where(id: params[:brand_id]).first.name
    elsif params[:search_product].present? && params[:search_product][:keyword].present? && params[:search_product][:category].present?
      ids = ProductCategory.where(category_id: params[:search_product][:category]).pluck(:product_id)
      products = Product.where("id IN (?)", ids)
      @products = products.where("name LIKE ?", "%" + params[:search_product][:keyword] + "%").order(:price).paginate(:page => params[:page], :per_page => 15)
    elsif params[:search_product].present? && params[:search_product][:keyword].present?
      @products = Product.where("name LIKE ?", "%" + params[:search_product][:keyword] + "%").order(:price).paginate(:page => params[:page], :per_page => 15)
    elsif params[:search_product].present? && params[:search_product][:category].present?
      ids = ProductCategory.where(category_id: params[:search_product][:category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids).order(:price).paginate(:page => params[:page], :per_page => 15)
    else
      @products = Product.all.order(:price).paginate(:page => params[:page], :per_page => 15)
      if @products.present?
        @category = @products.last.category.name
      end
    end
    render layout: "shop_application"
  end

  def product
    @product = Product.find(params[:id])
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
    if current_user.present? && current_user.orders.present?
      @order_items = current_user.orders.where(status: "pending").last.order_items
    end
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
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @order = current_user.orders
    total_price = 0
    if @order.present?
      @order = current_user.orders.where(status: "pending").last
      @order_items = @order.order_items
      @order_items.each do |o|
        product = Product.find(o.product_id)
        total_price += product.price.to_f*o.quantity.to_i+o.shipping.to_i
      end
    end
    $card = params[:card_info]
    begin
      customer = Stripe::Customer.retrieve(current_user.customer_id)
      id = customer.sources.create(source: generate_token).id
      user = current_user
      user.default_source = customer.default_source
      user.save
    rescue => e
      # Some other error; display an error message.
      flash[:notice] = e.message
      redirect_to checkout_path(value: "payment")
      return
    end
    begin
      charge = Stripe::Charge.create({
                                         amount: total_price.to_i*100,
                                         currency: 'usd',
                                         description: "Order no #{current_user.orders.last.id}",
                                         customer: current_user.customer_id,
                                     })
      order = current_user.orders.where(status: "pending").last
      order.status = "Paid"
      order.total_amount = total_price
      order.save
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
    redirect_to shop_path
  end

  private

  def shipping_params
    params.require(:shipping).permit( :name, :cntry_name, :street_address_one, :street_address_two, :state, :city, :postal_code, :mobile, :user_id)
  end
end
