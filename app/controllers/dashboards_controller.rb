class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def index
    render layout: "dashboard_application"
  end

  def brands_list
    @brands = Brand.all
    render layout: "dashboard_application"
  end

  def add_brand
    @brand = Brand.new
    render layout: "dashboard_application"
  end

  def create_brand
    brand = Brand.new(brand_params)
    if brand.save
      redirect_to brands_list_path
    else
      redirect_to add_brand_path
    end
  end

  def catergory_list
    @categories = Category.all
    render layout: "dashboard_application"
  end

  def add_catergory
    @category = Category.new
    render layout: "dashboard_application"
  end

  def create_catergory
    category = Category.new(category_params)
    if category.save
      redirect_to catergory_list_path
    else
      redirect_to add_catergory_path
    end
  end

  def sub_category_list
    @sub_categories = SubCategory.all
    render layout: "dashboard_application"
  end

  def add_sub_category
    @sub_category = SubCategory.new
    render layout: "dashboard_application"
  end

  def create_sub_category
    sub_category = SubCategory.new(sub_category_params)
    if sub_category.save
      redirect_to sub_category_list_path
    else
      redirect_to add_sub_category_path
    end
  end

  def product_type_list
    @product_types = ProductType.all
    render layout: "dashboard_application"
  end

  def add_product_type
    @product_type = ProductType.new
    render layout: "dashboard_application"
  end

  def create_product_type
    product_type = ProductType.new(product_type_params)
    if product_type.save
      redirect_to product_type_list_path
    else
      redirect_to add_product_type_path
    end
  end

  def product_color_list
    @product_colors = Color.all
    render layout: "dashboard_application"
  end

  def add_product_color
    @product_color = Color.new
    render layout: "dashboard_application"
  end

  def create_product_color
    product_color = Color.new(color_params)
    if product_color.save
      redirect_to product_color_list_path
    else
      redirect_to add_product_color_path
    end
  end

  def product_size_list
    @product_sizes = Size.all
    render layout: "dashboard_application"
  end

  def add_product_size
    @product_size = Size.new
    render layout: "dashboard_application"
  end

  def create_product_size
    product_size = Size.new(size_params)
    if product_size.save
      redirect_to product_size_list_path
    else
      redirect_to add_product_size_path
    end
  end

  def store
    @store = Store.where(user_id: current_user.id)
    render layout: "dashboard_application"
  end

  def add_store
    @store = Store.new
    render layout: "dashboard_application"
  end

  def shipping_prices
    @shipping_prices = ShippingPrice.all
    render layout: "dashboard_application"
  end

  def add_shipping_prices
    @shipping_price = ShippingPrice.new
    render layout: "dashboard_application"
  end

  def create_shipping_price
    shipping_price = ShippingPrice.new(shipping_price_params)
    if shipping_price.save
      redirect_to shipping_prices_path
    else
      redirect_to add_shipping_prices_path
    end
  end

  def create_store
    @store = Store.where(user_id: current_user.id)
    if @store.present?
      redirect_to add_store_path
    else
      store = Store.new(store_params)
    end
    if store.save
      redirect_to store_path
    else
      redirect_to add_store_path
    end
  end

  def product_list
    @product = Product.where(store_id: current_user.store.id)
    render layout: "dashboard_application"
  end

  def add_product
    @product = Product.new
    @product.product_shipments.build
    @product.product_specifications.build
    render layout: "dashboard_application"
  end

  def edit_product
    @product = Product.find(params[:product_id])
    @product.product_shipments.build
    @product.product_specifications.build
    render layout: "dashboard_application"
  end

  def update_product
    @product = Product.find(params[:product_id])
    @product.update_attributes(product_params)
    if @product.save
      if params[:product][:product_brand].present?
        ProductBrand.where(product_id: @product.id).destroy_all
        ProductBrand.create(product_id: @product.id, brand_id: params[:product][:product_brand].to_i)
      end
      if params[:product][:product_category].present?
        ProductCategory.where(product_id: @product.id).destroy_all
        ProductCategory.create(product_id: @product.id, category_id: params[:product][:product_category].to_i)
      end
      if params[:product][:product_sub_category].present?
        ProductSubCategory.where(product_id: @product.id).destroy_all
        ProductSubCategory.create(product_id: @product.id, sub_category_id: params[:product][:product_sub_category].to_i)
      end
      if params[:product][:product_group].present?
        ProductGroup.where(product_id: @product.id).destroy_all
        ProductGroup.create(product_id: @product.id, product_type_id: params[:product][:product_group].to_i)
      end

      if params[:product][:color_ids].present?
        ProductColor.where(product_id: @product.id).destroy_all
        product_color_ids = params[:product][:color_ids].reject { |c| c.empty? }
        product_color_ids.each do |color|
          ProductColor.create(product_id: @product.id, color_id: color.to_i)
        end
      end

      if params[:product][:size_ids].present?
        ProductSize.where(product_id: @product.id).destroy_all
        product_color_ids = params[:product][:size_ids].reject { |c| c.empty? }
        product_color_ids.each do |color|
          ProductSize.create(product_id: @product.id, size_id: color.to_i)
        end
      end
      if params[:images].present?
        params[:images].each { |image|
          ProductImage.create(image: image, product_id: @product.id)
        }
      end
      redirect_to product_list_path
    else
      redirect_to edit_product_path
    end
  end

  def delete_product
      @product = Product.find(params[:id])
     if @product.destroy
       redirect_to product_list_path
     end
  end

  def create_product
    @product = Product.new(product_params)
    if @product.save
      if params[:product][:product_brand].present?
        ProductBrand.create(product_id: @product.id, brand_id: params[:product][:product_brand].to_i)
      end
      if params[:product][:product_category].present?
        ProductCategory.create(product_id: @product.id, category_id: params[:product][:product_category].to_i)
      end
      if params[:product][:product_sub_category].present?
        ProductSubCategory.create(product_id: @product.id, sub_category_id: params[:product][:product_sub_category].to_i)
      end
      if params[:product][:product_group].present?
        ProductGroup.create(product_id: @product.id, product_type_id: params[:product][:product_group].to_i)
      end

      if params[:product][:color_ids].present?
        product_color_ids = params[:product][:color_ids].reject { |c| c.empty? }
        product_color_ids.each do |color|
          ProductColor.create(product_id: @product.id, color_id: color.to_i)
        end
      end

      if params[:product][:size_ids].present?
        product_color_ids = params[:product][:size_ids].reject { |c| c.empty? }
        product_color_ids.each do |color|
          ProductSize.create(product_id: @product.id, size_id: color.to_i)
        end
      end
      if params[:images].present?
        params[:images].each { |image|
          ProductImage.create(image: image, product_id: @product.id)
        }
      end
      redirect_to product_list_path
    else
      redirect_to add_product_path
    end
  end


  def orders_list
    @orders = Order.where(user_id: current_user.id)
    render layout: "dashboard_application"
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :vendor_name, :vendor_email, :vendor_number, :logo)
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end

  def sub_category_params
    params.require(:sub_category).permit(:name, :category_id, :image)
  end

  def product_type_params
    params.require(:product_type).permit(:name, :sub_category_id, :image)
  end

  def store_params
    params.require(:store).permit(:name, :description, :user_id)
  end

  def color_params
    params.require(:color).permit(:name)
  end

  def size_params
    params.require(:size).permit(:name)
  end

  def product_params
    params.require(:product).permit( :name, :description, :sku, :supplier_url, :sale_off_percent, :price, :additional_information, :article_number, :vendor_store_product_number, :weight, :store_id, :sale, :active, product_shipments_attributes: [:id, :name, :price, :_destroy], product_specifications_attributes: [:id, :spec_key, :spec_value, :_destroy])
  end

  def shipping_price_params
    params.require(:shipping_price).permit(:name, :price)
  end
end
