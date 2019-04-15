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
    # gon.client_token = generate_client_token
  end

  def process_payment
    @order = current_user.orders.last
    locations_api = SquareConnect::LocationsApi.new
    begin
    locations_response = locations_api.list_locations
      puts locations_response
    rescue SquareConnect::ApiError => e
      raise "Error encountered while listing locations: #{e.message}"
    end
    location = locations_response.locations.detect do |l|
      l.capabilities.include?("CREDIT_CARD_PROCESSING")
    end
    if location.nil?
      flash[:notice] = "Your location is not permited to charge a card"
      redirect_to  checkout_shopping_carts_path and return
    end
    transactions_api = SquareConnect::TransactionsApi.new
    request_body = {
    :card_nonce => params[:nonce],
    :amount_money => {
      :amount => @order.total_price.round(0)*100,
      :currency => 'USD'},
      :idempotency_key => SecureRandom.uuid }
    begin
      resp = transactions_api.charge(ENV['SQUARE_CONNECT_LOCATION_ID'], request_body)
    rescue SquareConnect::ApiError => e
      flash[:notice] = "Error encountered while charging card: #{e.message}"
      redirect_to checkout_shopping_carts_path and return
    end
    flash[:notice] = "Card Charged successfully"
    session.delete(:shop_cart)
    @order.update(status:"paid")
    redirect_to  checkout_shopping_carts_path(value: "done")
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

