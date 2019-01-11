module HomeHelper
  def get_t_shirts
    ProductType.where(name:"T-Shirts").take.products
  end

  def get_blazers
    ProductType.where(name:"Blazers").take.products
  end

  def get_car_lights
    ProductType.where(name:"Car Lights").take.products
  end

  def get_men_shirts
    ProductType.where(name:"Shirts").take.products
  end

  def get_men_jeans
    Category.where(name:"Men’s Clothing").take.sub_categories.where(name:"Bottoms").take.product_types.where(name:"Jeans").take.products
  end

  def get_men_under_garments
    ProductType.where(name:"Boxers").take.products
  end
end
