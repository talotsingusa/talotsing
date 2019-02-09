class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_destroy do
    @order = self.order
  end

  after_destroy do
    unless @order.order_items.any?
      @order.destroy
    end
  end

end
