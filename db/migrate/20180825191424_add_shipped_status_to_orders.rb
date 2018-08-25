class AddShippedStatusToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :shipping_status, :string, default: "pending"
  end
end
