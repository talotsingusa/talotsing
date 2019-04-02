class Card < ApplicationRecord
  belongs_to :order
  belongs_to :user

  attr_accessor :card_number, :card_verification

  validates :card_number, :card_verification, numericality: true
  before_create :validate_card
  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
  end

  def price_in_cents
    order.total_price
  end


  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
        type:                card_type,
        number:              card_number,
        verification_value:  card_verification,
        month:               card_expires_on.month,
        year:                card_expires_on.year,
        first_name:          first_name,
        last_name:           last_name
    )
  end

  def purchase_options
    {
      ip: ip_address,
      billing_address: {
        name:      "Flaying Cakes",
        address1:  "123 5th Av.",
        city:      "New York",
        state:     "NY",
        country:   "US",
        zip:       "10001"
        }
    }
  end

  private

    def validate_card
      unless credit_card.valid?
        credit_card.errors.full_messages.each do |message|
          errors.add :base, message
        end
      end
    end
end
