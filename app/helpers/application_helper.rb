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
      recently_viewed = RecentView.where(user_id: current_user.id).pluck(:product_id)
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
        @price = Product.find(product[0].to_i).price*product[1].to_i+product[4].to_i
        total_price << @price
      end
    elsif current_user.present? && current_user.orders.where(status: "pending").present?
      if current_user.orders.present?
        @order_items = current_user.orders.where(status: "pending").last.order_items
        @order_items.each do |product|
          if product.quantity.nil?
            @price = Product.find(product.product_id).price*1
          else
            @price = Product.find(product.product_id).price*product.quantity+product.shipping.to_i
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
end
