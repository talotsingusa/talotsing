class CreateProductSubCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :product_sub_categories do |t|
      t.integer :product_id
      t.integer :sub_category_id

      t.timestamps
    end
  end
end
