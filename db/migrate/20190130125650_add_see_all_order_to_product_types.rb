class AddSeeAllOrderToProductTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :product_types, :see_all_order, :integer, default: 0
  end
end
