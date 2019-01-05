class AddUiIdToProductTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :product_types, :ui_id, :integer, default: 0
  end
end
