module DashboardsHelper
  def display_dispatch_order_status_link(order)
    order.shipping_status != "Order Dispatched"
  end
end
