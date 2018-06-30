class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :sku
      t.float :price
      t.text :additional_information
      t.integer :store_id
      t.boolean :sale
      t.boolean :active
      t.boolean :approved

      t.timestamps
    end
  end
end
