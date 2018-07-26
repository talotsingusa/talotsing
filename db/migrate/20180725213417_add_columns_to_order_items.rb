class AddColumnsToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :size, :string
    add_column :order_items, :color, :string
    add_column :order_items, :shipping, :string
  end
end
