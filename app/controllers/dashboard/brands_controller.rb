class Dashboard:: BrandsController < Dashboard:: BaseController
before_action :set_brand, only: [:show, :edit, :destroy]

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to dashboard_brands_path
    else
      redirect_to new_dashboard_brand_path
    end
  end

  def edit
  end

  def update
    if @brand.update(brand_params)
      redirect_to dashboard_brands_path
    else
      redirect_to new_dashboard_brand_path
    end
  end

  def destroy
    @brand.destroy
    redirect_to dashboard_brands_path
  end

  private

  def brand_params
    params.require(:brand).permit(:name, :vendor_name, :vendor_email, :vendor_number, :logo)
  end

  def set_brand
    @brand = Brand.find(params[:id])
  end
end
