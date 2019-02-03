class AddUiOrderToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :ui_order, :integer, default: 0
  end
end
