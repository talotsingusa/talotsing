module ApplicationHelper

  def check_favorite(product_id)
    if current_user.present?
      favorite = UserFavorite.where(user_id: current_user.id, product_id: product_id)
      if favorite.present?
        return true
      else
        return false
      end
    else
      if !session[:favorites].nil?
        if session[:favorites].include?(product_id)
          return true
        else
          return false
        end
      end
    end
  end

  def recently_viewed_products
    if current_user.present?
      recently_viewed = RecentView.where(user_id: current_user.id).pluck(:product_id).uniq
      if recently_viewed.present?
        return Product.where("id IN (?)", recently_viewed)
      end
    else
      if !session[:recent_views].nil? && session[:recent_views].count > 0
        return Product.where("id IN (?)", session[:recent_views].uniq)
      end
    end
  end

  def cart_total
    total_price = []
    if !session[:shop_cart].nil? && session[:shop_cart].count > 0
      session[:shop_cart].each do |product|
        get_product = Product.find_by_id(product[0].to_i)
        if get_product.present?
          @price = (Product.find(product[0].to_i).price+product[4].to_i)*product[1].to_i
          total_price << @price
        end
      end
    elsif current_user.present? && current_user.orders.where(status: "pending").present?
      if current_user.orders.present?
        @order_items = current_user.orders.where(status: "pending").last.order_items
        @order_items.each do |product|
          if product.quantity.nil?
            get_product = Product.find_by_id(product.product_id)
            if get_product.present?
              @price = (Product.find(product.product_id).price+product.shipping)*1
            end
          else
            get_product = Product.find_by_id(product.product_id)
            if get_product.present?
              @price = (Product.find(product.product_id).price+product.shipping.to_i)*product.quantity
            end
          end
          total_price << @price
        end
      end
    end
    sum = 0
    price = total_price.each { |a| sum+=a }
    if !sum.nil?
      return sum
    else
      return 0
    end

  end

  def cart_total_mailer(id)
    total_price = []
    order = Order.find(id)
    if order.present?
      @order_items = order.order_items
      @order_items.each do |product|
        if product.quantity.nil?
          get_product = Product.find_by_id(product.product_id)
          if get_product.present?
            @price = (Product.find(product.product_id).price+product.shipping)*1
          end
        else
          get_product = Product.find_by_id(product.product_id)
          if get_product.present?
            @price = (Product.find(product.product_id).price+product.shipping.to_i)*product.quantity
          end
        end
        total_price << @price
      end
    end
    sum = 0
    price = total_price.each { |a| sum+=a }
    if !sum.nil?
      return sum
    else
      return 0
    end

  end

  def shipping_cost(id)
    order = Order.find(id)
    total_price = []
    @order_items = order.order_items
    @order_items.each do |item|
      total_price << item.shipping.to_i*item.quantity.to_i
    end
    return total_price.sum
  end

  def cart_products
    arr = []
    if !session[:shop_cart].nil? && session[:shop_cart].count > 0
      session[:shop_cart].each do |product|
        arr << product[0]
      end
    end
    products = Product.where("id IN (?)", arr)
    return products
  end

  def product_details(id)
    return Product.find(id)
  end

  def online_status(user)
    content_tag :span, user.first_name,
                class: "user-#{user.id} online_status #{'online' if user.online?}"
  end

  def sub_category_image(product_type)
    no_image = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"
    if product_type.present?
      product_groups = ProductGroup.where(product_type_id: product_type.id)
      if product_groups.present?
        product = Product.find(product_groups.last.product_id)
        return product.product_images.first.image.url(:original)
      else
        return no_image
      end
    else
      return no_image
    end

  end

  def get_products(id)
    product_ids = ProductGroup.where(product_type_id: id).pluck(:product_id).uniq
    if product_ids.present?
      return Product.where("id IN (?)", product_ids).limit(5)
    else
      return nil
    end
  end

  def product_image_check(product)
    if product.present?
      return product.product_images.first.image.url
    end
  end

  def mobile? # has to be in here because it has access to "request"
    request.user_agent =~ /\b(Android|iPhone|iPad|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook)\b/i
  end

  def get_fine_jewlery_products
    SubCategory.where(name:"Fine Jewelry").take.product_types
  end

  def get_toys_and_hobbies_products
    SubCategory.where(name:"Toys & Hobbies").take.product_types
  end

  def get_mobile_phone_accessories_products
    SubCategory.where(name:"Mobile Phone Accessories").take.product_types
  end

  def get_makeup_products
    SubCategory.where(name:"Makeup").take.product_types
  end

end
