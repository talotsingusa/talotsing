class AddSeeAllOrderToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :see_all_order, :integer, default:0
  end
end
