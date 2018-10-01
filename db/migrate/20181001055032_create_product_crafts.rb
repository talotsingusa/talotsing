class CreateProductCrafts < ActiveRecord::Migration[5.1]
  def change
    create_table :product_crafts do |t|
      t.integer :product_id
      t.integer :craft_id

      t.timestamps
    end
  end
end
