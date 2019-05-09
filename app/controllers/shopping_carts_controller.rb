class ShoppingCartsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def checkout
    if params[:value].present?
      @value = params[:value]
    end
    if current_user.present? && current_user.orders.present?
      @order_items = current_user.orders.pending
      if @order_items.present?
        @order_items = current_user.orders.pending.last.order_items
      end
    end
    if current_user.present?
      if current_user.shipping.present?
        @shipping = current_user.shipping
      else
        @shipping = Shipping.new
      end
      render layout: "purchase_application"
    else
      redirect_to user_session_path
    end
  end

  def process_payment
    @order = current_user.orders.last
    location = SquareConnectServices.location(flash)
    begin
      responce = SquareConnectServices.transaction(params[:nonce], @order.total_price.to_i)
      flash[:notice] = "Card Charged successfully"
      session.delete(:shop_cart)
      @order.update(status:"paid")
      url = "#{request.base_url}/my_order_details?id=#{@order.id}"
      MessageMailer.email_admin(current_user, url, @order).deliver_now
      MessageMailer.order_email(current_user.email, current_user.name, current_user, url, @order).deliver_now
      redirect_to  checkout_shopping_carts_path(value: "done")
    rescue SquareConnect::ApiError => e
      flash[:notice] = "Error encountered while charging card: #{e.message}"
      redirect_to checkout_shopping_carts_path and return
    end
  end

  def remove_items_from_cart
    session[:shop_cart].present? ? session[:shop_cart].delete_if {|product| product[0] == params[:product]} : OrderItem.find(params[:order_item].to_i).destroy
    redirect_to checkout_shopping_carts_path
  end

  private
    def card_params
      params.require(:card_info).permit(:first_name, :last_name, :card_type, :card_expires_on, :card_verification, :card_number)
    end
end

