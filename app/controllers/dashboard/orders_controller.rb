class Dashboard::OrdersController < Dashboard:: BaseController

  def index
    @orders = Order.all
  end

  def pending_orders
    @orders = Order.where.not(shipping_status: "Order dispatched")
  end

  def dispatched_orders
    @orders = Order.where(shipping_status: "Order dispatched")
  end

  def completed_orders

  end

end
