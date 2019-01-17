class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    return root_path if resource.class != String
    user = User.find(resource.id)

    if resource.email  == "admin@gmail.com"
      dashboards_path
    elsif resource.profile_type == "vendor"
      dashboards_path
    elsif resource.profile_type == "customer"
      if !session[:favorites].nil? && session[:favorites].count > 0
        session[:favorites].each do |favorite|
          UserFavorite.create(user_id: current_user.id, product_id: favorite)
        end
      end
      if !session[:recent_views].nil? && session[:recent_views].count > 0
        session[:recent_views].each do |recent|
          RecentView.create(user_id: current_user.id, product_id: recent)
        end
      end
      if !session[:shop_cart].nil? && session[:shop_cart].count > 0
        order = Order.where(user_id: current_user.id, status: "pending")
        if order.present?
          order = Order.where(user_id: current_user.id, status: "pending").last
        else
          order = Order.create(user_id: current_user.id)
        end
        order_id = order.id
        session[:shop_cart].each do |product|
          OrderItem.create(product_id: product[0], quantity: product[1], size: product[2], color: product[3], shipping: product[4], order_id: order_id)
        end

      end
      session.delete(:shop_cart)
      session.delete(:favorites)
      session.delete(:recent_views)
      root_path
    else
      # do nothing
    end
  end
end
