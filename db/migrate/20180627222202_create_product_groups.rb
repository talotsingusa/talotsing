class CreateProductGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :product_groups do |t|
      t.integer :product_id
      t.integer :product_type_id

      t.timestamps
    end
  end
end
