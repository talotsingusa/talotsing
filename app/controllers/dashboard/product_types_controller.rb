class Dashboard::ProductTypesController < Dashboard:: BaseController

  def index
    @product_types = ProductType.includes(:sub_category).all
  end

  def new
    @product_type = ProductType.new
  end

  def create
    @product_type = ProductType.new(product_type_params)
    if @product_type.save
      redirect_to dashboard_product_types_path
    else
      redirect_to new_dashboard_product_type_path
    end
  end

  private

  def product_type_params
    params.require(:product_type).permit(:name, :sub_category_id, :image, :see_all)
  end

end
