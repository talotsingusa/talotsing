class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    session[:shop_cart] = nil
    session[:favorites] = nil
  end

  def shop
    if params[:category].present?
      ids = ProductCategory.where(category_id: params[:category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids)
      @category = Category.where(id: params[:category]).first.name
    elsif params[:sub_category].present?
      ids = ProductSubCategory.where(sub_category_id: params[:sub_category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids)
      @category = SubCategory.where(id: params[:sub_category]).first.name
    elsif params[:product_type].present?
      ids = ProductGroup.where(product_type_id: params[:product_type]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids)
      @category = ProductType.where(id: params[:product_type]).first.name
    elsif params[:brand_id].present?
      ids = ProductBrand.where(brand_id: params[:brand_id]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids)
      @category = Brand.where(id: params[:brand_id]).first.name
    elsif params[:search_product].present? && params[:search_product][:keyword].present? && params[:search_product][:category].present?
      ids = ProductCategory.where(category_id: params[:search_product][:category]).pluck(:product_id)
      products = Product.where("id IN (?)", ids)
      @products = products.where("name LIKE ?", "%" + params[:search_product][:keyword] + "%")
    elsif params[:search_product].present? && params[:search_product][:keyword].present?
      @products = Product.where("name LIKE ?", "%" + params[:search_product][:keyword] + "%")
    elsif params[:search_product].present? && params[:search_product][:category].present?
      ids = ProductCategory.where(category_id: params[:search_product][:category]).pluck(:product_id)
      @products = Product.where("id IN (?)", ids)
    else
      @products = Product.all
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
      @order_items = current_user.orders.last.order_items
    end
    render layout: "cart_application"
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
      @products = Product.where("id IN (?)", favorites_ids)
    else
      if !session[:favorites].nil?
        @products = Product.where("id IN (?)", session[:favorites])
      end
    end
    render layout: "shop_application"
  end

  def add_to_cart
    if current_user.present?
      order = Order.where(user_id: current_user.id)
      if order.present?
        order_id = order.last.id
      else
        order = Order.create(user_id: current_user.id)
        order_id = order.id
      end
      order_item = OrderItem.create(product_id: params[:add_product_to_cart][:product_id], quantity: params[:add_product_to_cart][:quantity], order_id: order_id)
    else
      # session.delete(:favorites)
      product_array = [params[:add_product_to_cart][:product_id], params[:add_product_to_cart][:quantity]]
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

end
