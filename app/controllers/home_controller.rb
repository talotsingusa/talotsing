class HomeController < ApplicationController

  def index

  end

  def shop
    render layout: "shop_application"
  end

  def product
    render layout: "product_application"
  end

  def cart
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
end
