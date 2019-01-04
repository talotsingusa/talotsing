class AddUiOrderToSubCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :sub_categories, :ui_order, :integer, default:0
  end
end
