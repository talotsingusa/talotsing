class Dashboard:: BrandsController < Dashboard:: BaseController

  def index
    @brands = Brand.all
    render layout: "dashboard_application"
  end

end
