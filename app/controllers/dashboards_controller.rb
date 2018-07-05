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
    render layout: "dashboard_application"
    @brand = Brand.new
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
    render layout: "dashboard_application"
    @category = Category.new
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
    render layout: "dashboard_application"
    @sub_category = SubCategory.new
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
    render layout: "dashboard_application"
    @product_type = ProductType.new
  end

  def create_product_type
    product_type = ProductType.new(product_type_params)
    if product_type.save
      redirect_to product_type_list_path
    else
      redirect_to add_product_type_path
    end
  end

  def store
    @store = Store.where(user_id: current_user.id)
    render layout: "dashboard_application"
  end

  def add_store
    render layout: "dashboard_application"
    @store = Store.new
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
    render layout: "dashboard_application"
    @product = Product.new
    @product.product_shipments.build
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

  private

  def brand_params
    params.require(:brand).permit(:name, :logo)
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

  def product_params
    params.require(:product).permit( :name, :description, :sku, :price, :additional_information, :store_id, :sale, :active, product_shipments_attributes: [:id, :name, :price, :_destroy])
  end
end
