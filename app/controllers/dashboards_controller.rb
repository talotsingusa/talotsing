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

  def edit_category
    @category = Category.find(params[:id])
    render layout: "dashboard_application"
  end

  def update_category
    category = Category.find(params[:category][:id])
    if category.update(category_params)
      redirect_to catergory_list_path
    else
      redirect_to update_category_path
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

  def closure_type_list
    @product_closure_types = ClosureType.all
    render layout: "dashboard_application"
  end

  def add_closure_type
    @product_closure_type = ClosureType.new
    render layout: "dashboard_application"
  end

  def create_closure_type
    closure_type  = ClosureType.new(closure_type_params)
    if closure_type.save
      redirect_to closure_type_list_path
    else
      redirect_to add_closure_type_path
    end
  end

  def collar_list
    @product_collars = Collar.all
    render layout: "dashboard_application"
  end

  def add_collar_type
    @product_collar = Collar.new
    render layout: "dashboard_application"
  end

  def create_collar_type
    product_collar   = Collar.new(collar_params)
    if product_collar.save
      redirect_to collar_list_path
    else
      redirect_to add_collar_type_path
    end
  end

  def craft_list
    @product_crafts = Craft.all
    render layout: "dashboard_application"
  end

  def add_craft_type
    @product_craft = Craft.new
    render layout: "dashboard_application"
  end

  def create_craft_type
    product_craft  = Craft.new(craft_params)
    if product_craft.save
      redirect_to craft_list_path
    else
      redirect_to add_craft_type_path
    end
  end


  def design_list
    @product_designs = Design.all
    render layout: "dashboard_application"
  end

  def add_design
    @product_design = Design.new
    render layout: "dashboard_application"
  end

  def create_design
    product_design = Design.new(design_params)
    if product_design.save
      redirect_to design_list_path
    else
      redirect_to add_design_path
    end
  end

  def design_type_list
    @product_design_types = DesignType.all
    render layout: "dashboard_application"
  end

  def add_design_type
    @product_design_type = DesignType.new
    render layout: "dashboard_application"
  end

  def create_design_type
    product_design_type = DesignType.new(design_type_params)
    if product_design_type.save
      redirect_to design_type_list_path
    else
      redirect_to add_design_type_path
    end
  end

  def pattern_style_list
    @product_pattern_styles = PatternStyle.all
    render layout: "dashboard_application"
  end

  def add_pattern_style
    @product_pattern_style = PatternStyle.new
    render layout: "dashboard_application"
  end

  def create_pattern_style
    product_pattern_style = PatternStyle.new(pattern_style_params)
    if product_pattern_style.save
      redirect_to pattern_style_list_path
    else
      redirect_to add_pattern_style_path
    end
  end

  def sleeve_type_list
    @product_sleeve_types = SleeveType.all
    render layout: "dashboard_application"
  end

  def add_sleeve_type
    @product_sleeve_type = SleeveType.new
    render layout: "dashboard_application"
  end

  def create_sleeve_type
    product_sleeve_type = SleeveType.new(sleeve_type_params)
    if product_sleeve_type.save
      redirect_to sleeve_type_list_path
    else
      redirect_to add_sleeve_type_path
    end
  end

  def styles_list
    @product_styles = Style.all
    render layout: "dashboard_application"
  end

  def add_style
    @product_style = Style.new
    render layout: "dashboard_application"
  end

  def create_style
    product_style = Style.new(style_params)
    if product_style.save
      redirect_to styles_list_path
    else
      redirect_to add_style_path
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
    @product.product_color_images.build
    render layout: "dashboard_application"
  end

  def edit_product
    @product = Product.find(params[:product_id])
    @product.product_shipments.build
    @product.product_specifications.build
    @product.product_color_images.build
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

      if params[:product][:closure_type_ids].present?
        ProductClosureType.where(product_id: @product.id).destroy_all
        product_closure_ids = params[:product][:closure_type_ids].reject { |c| c.empty? }
        product_closure_ids.each do |product_closure|
          ProductClosureType.create(product_id: @product.id, closure_type_id: product_closure.to_i)
        end
      end

      if params[:product][:collar_ids].present?
        ProductCollar.where(product_id: @product.id).destroy_all
        product_collar_ids = params[:product][:collar_ids].reject { |c| c.empty? }
        product_collar_ids.each do |collar|
          ProductCollar.create(product_id: @product.id, collar_id: collar.to_i)
        end
      end

      if params[:product][:craft_ids].present?
        ProductCraft.where(product_id: @product.id).destroy_all
        product_craft_ids = params[:product][:craft_ids].reject { |c| c.empty? }
        product_craft_ids.each do |product_craft|
          ProductCraft.create(product_id: @product.id, craft_id: product_craft.to_i)
        end
      end

      if params[:product][:design_ids].present?
        ProductDesign.where(product_id: @product.id).destroy_all
        product_design_ids = params[:product][:design_ids].reject { |c| c.empty? }
        product_design_ids.each do |product_design|
          ProductDesign.create(product_id: @product.id, design_id: product_design.to_i)
        end
      end

      if params[:product][:design_type_ids].present?
        ProductDesignType.where(product_id: @product.id).destroy_all
        product_design_type_ids = params[:product][:design_type_ids].reject { |c| c.empty? }
        product_design_type_ids.each do |product_design_type|
          ProductDesignType.create(product_id: @product.id, design_type_id: product_design_type.to_i)
        end
      end

      if params[:product][:pattern_style_ids].present?
        ProductPatternStyle.where(product_id: @product.id).destroy_all
        product_pattern_style_ids = params[:product][:pattern_style_ids].reject { |c| c.empty? }
        product_pattern_style_ids.each do |product_pattern_style|
          ProductPatternStyle.create(product_id: @product.id, pattern_style_id: product_pattern_style.to_i)
        end
      end

      if params[:product][:sleeve_type_ids].present?
        ProductSleeveType.where(product_id: @product.id).destroy_all
        product_sleeve_type_ids = params[:product][:sleeve_type_ids].reject { |c| c.empty? }
        product_sleeve_type_ids.each do |product_sleeve_type|
          ProductSleeveType.create(product_id: @product.id, sleeve_type_id: product_sleeve_type.to_i)
        end
      end

      if params[:product][:style_ids].present?
        ProductStyle.where(product_id: @product.id).destroy_all
        product_style_ids = params[:product][:style_ids].reject { |c| c.empty? }
        product_style_ids.each do |product_style|
          ProductStyle.create(product_id: @product.id, style_id: product_style.to_i)
        end
      end

      if params[:images].present?
        params[:images].each { |image|
          ProductImage.create(image: image, product_id: @product.id)
        }
      end
      flash[:notice] = 'product update successfully'
      redirect_to dashboards_path
    else
      redirect_to edit_product_path(product_id: @product.id)
    end
  end

  def delete_product
      @product = Product.find(params[:id])
     if @product.destroy
       flash[:notice] = 'product deleted successfully'
       redirect_to dashboards_path
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

      if params[:product][:closure_type_ids].present?
        product_closure_ids = params[:product][:closure_type_ids].reject { |c| c.empty? }
        product_closure_ids.each do |product_closure|
          ProductClosureType.create(product_id: @product.id, closure_type_id: product_closure.to_i)
        end
      end

      if params[:product][:collar_ids].present?
        product_collar_ids = params[:product][:collar_ids].reject { |c| c.empty? }
        product_collar_ids.each do |collar|
          ProductCollar.create(product_id: @product.id, collar_id: collar.to_i)
        end
      end

      if params[:product][:craft_ids].present?
        product_craft_ids = params[:product][:craft_ids].reject { |c| c.empty? }
        product_craft_ids.each do |product_craft|
          ProductCraft.create(product_id: @product.id, craft_id: product_craft.to_i)
        end
      end

      if params[:product][:design_ids].present?
        product_design_ids = params[:product][:design_ids].reject { |c| c.empty? }
        product_design_ids.each do |product_design|
          ProductDesign.create(product_id: @product.id, design_id: product_design.to_i)
        end
      end

      if params[:product][:design_type_ids].present?
        product_design_type_ids = params[:product][:design_type_ids].reject { |c| c.empty? }
        product_design_type_ids.each do |product_design_type|
          ProductDesignType.create(product_id: @product.id, design_type_id: product_design_type.to_i)
        end
      end

      if params[:product][:pattern_style_ids].present?
        product_pattern_style_ids = params[:product][:pattern_style_ids].reject { |c| c.empty? }
        product_pattern_style_ids.each do |product_pattern_style|
          ProductPatternStyle.create(product_id: @product.id, pattern_style_id: product_pattern_style.to_i)
        end
      end

      if params[:product][:sleeve_type_ids].present?
        product_sleeve_type_ids = params[:product][:sleeve_type_ids].reject { |c| c.empty? }
        product_sleeve_type_ids.each do |product_sleeve_type|
          ProductSleeveType.create(product_id: @product.id, sleeve_type_id: product_sleeve_type.to_i)
        end
      end

      if params[:product][:style_ids].present?
        product_style_ids = params[:product][:style_ids].reject { |c| c.empty? }
        product_style_ids.each do |product_style|
          ProductStyle.create(product_id: @product.id, style_id: product_style.to_i)
        end
      end

      if params[:images].present?
        params[:images].each { |image|
          ProductImage.create(image: image, product_id: @product.id)
        }
      end
      flash[:notice] = 'Product added successfully.'
      redirect_to add_product_path
    else
      flash[:notice] = 'product has failed to upload'
      redirect_to add_product_path
    end
  end


  def orders_list
    @orders = Order.where(user_id: current_user.id)
    render layout: "dashboard_application"
  end

  def pending_orders
    @orders = Order.where.not(shipping_status: "Order dispatched")
    render layout: "dashboard_application"
  end

  def completed_orders
    @orders = Order.where(shipping_status: "Order dispatched")
    render layout: "dashboard_application"
  end

  def order_details
    @order = Order.find(params[:id])
    render layout: "dashboard_application"
  end

  def my_order_details
    @order = Order.find(params[:id])
    render layout: "dashboard_application"
  end

  def change_product_status
    @order_item = OrderItem.find(params[:id])
    @order_item.status = params[:status]
    @order_item.save
    redirect_to order_details_path(id: @order_item.order_id)
  end

  def change_order_status
    @order = Order.find(params[:id])
    @order.shipping_status = params[:status]
    @order.save
    redirect_to pending_orders_path
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

  def closure_type_params
    params.require(:closure_type).permit(:name)
  end

  def collar_params
    params.require(:collar).permit(:name)
  end

  def craft_params
    params.require(:craft).permit(:name)
  end

  def design_params
    params.require(:design).permit(:name)
  end

  def design_type_params
    params.require(:design_type).permit(:name)
  end

  def pattern_style_params
    params.require(:pattern_style).permit(:name)
  end

  def sleeve_type_params
    params.require(:sleeve_type).permit(:name)
  end

  def style_params
    params.require(:style).permit(:name)
  end


  def product_params
    params.require(:product).permit( :name, :description, :sku, :supplier_url, :sale_off_percent, :price, :additional_information, :article_number, :vendor_store_product_number, :weight, :store_id, :sale, :active, product_shipments_attributes: [:id, :name, :price, :_destroy], product_specifications_attributes: [:id, :spec_key, :spec_value, :_destroy], product_color_images_attributes: [:id, :color, :image, :_destroy])
  end

  def shipping_price_params
    params.require(:shipping_price).permit(:name, :price)
  end
end
