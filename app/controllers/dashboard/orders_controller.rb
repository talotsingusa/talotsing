class Dashboard::OrdersController < Dashboard:: BaseController

  def index
    @orders = Order.all
  end

  def unpaid_orders
    @orders = Order.all.pending
  end

  def paid_orders
    @orders = Order.all.paid
  end

  def shipped_orders
    @orders = Order.all.shipped
  end

  def ship_order
    @order = Order.find(params[:id])
    @order.update(status: 'shipped')
    redirect_to paid_orders_dashboard_orders_path
  end

end
