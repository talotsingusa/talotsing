class ChangeIntegerLimitInProduct < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :sku, :integer, limit: 8
  end
end
