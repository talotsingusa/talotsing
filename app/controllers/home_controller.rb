class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index

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
    elsif params[:search_product][:keyword].present? && params[:search_product][:category].present?
      ids = ProductCategory.where(category_id: params[:search_product][:category]).pluck(:product_id)
      products = Product.where("id IN (?)", ids)
      @products = products.where("name LIKE ?", "%" + params[:search_product][:keyword] + "%")
    elsif params[:search_product][:keyword].present?
      @products = Product.where("name LIKE ?", "%" + params[:search_product][:keyword] + "%")
    elsif params[:search_product][:category].present?
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
