module HomeHelper
  def get_t_shirts
    ProductType.where(name:"T-Shirts").take.products.includes(:product_images)
  end

  def get_blazers
    ProductType.where(name:"Blazers").take.products.includes(:product_images)
  end

  def get_car_lights
    ProductType.where(name:"Car Lights").take.products.includes(:product_images)
  end

  def get_men_shirts
    ProductType.where(name:"Shirts").take.products.includes(:product_images)
  end

  def get_men_jeans
    Category.where(name:"Men’s Clothing").take.sub_categories.where(name:"Bottoms").take.product_types.where(name:"Jeans").take.products.includes(:product_images)
  end

  def get_men_under_garments
    ProductType.where(name:"Boxers").take.products.includes(:product_images)
  end

  def product_types? sub_category
    puts "******************************************************************************"
    puts sub_category.product_types.present?
    puts sub_category.name
    sub_category.product_types.present?
  end
end
