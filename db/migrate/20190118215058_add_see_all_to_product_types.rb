class AddSeeAllToProductTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :product_types, :see_all, :boolean, default: false
  end
end
