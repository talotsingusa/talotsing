class SquareConnectServices
  class << self
    def location(flash)
      locations_api = SquareConnect::LocationsApi.new
      locations_response = locations_api.list_locations rescue nil
      unless locations_response.nil?
        location = locations_response.locations.detect do |l|
          l.capabilities.include?("CREDIT_CARD_PROCESSING")
        end
        return location
      end
      flash[:notice] = "Your location is not permited to charge a card"
      redirect_to  checkout_shopping_carts_path and return
    end

    def transaction(nonce, amount)
      transactions_api = SquareConnect::TransactionsApi.new
      request_body = {
        card_nonce: nonce,
        amount_money: {
        amount: amount,
        currency: 'USD'
      },
        idempotency_key: SecureRandom.uuid
      }
      transactions_api.charge(ENV['SQUARE_CONNECT_LOCATION_ID'], request_body)
    end
  end
end
