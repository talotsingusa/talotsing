class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user
  has_one :card

  enum status: ["pending", "paid", "shipped", "completed"]

  before_create :set_default_status

  def set_default_status
    self.status="pending"
  end

  def total_price
    total_price = 0
    order_items.each do |order|
      product = order.product
      total_price += (product.price.to_f+order.shipping.to_i)*order.quantity.to_i
    end
    total_price.round(0)*100 # In cents
  end

end
