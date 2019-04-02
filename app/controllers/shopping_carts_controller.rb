class ShoppingCartsController < ApplicationController
  before_action :authenticate_user!

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
    @card = current_user.cards.new(card_params)
    @card.ip_address = request.remote_ip
    @order.card = @card
    @order.save
    responce = @order.card.purchase
    if responce.success?
      flash[:notice] = 'Card charged successfully.'
      session.delete(:shop_cart)
      @order.update(status:"paid")
      redirect_to  checkout_shopping_carts_path(value: "done")
    else
      @order.card.destroy
      flash[:notice] = response.message
    end
  end

  private
    def card_params
      params.require(:card_info).permit(:first_name, :last_name, :card_type, :card_expires_on, :card_verification, :card_number)
    end

end

