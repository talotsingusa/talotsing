class CreateProductShipments < ActiveRecord::Migration[5.1]
  def change
    create_table :product_shipments do |t|
      t.string :name
      t.integer :price
      t.integer :product_id

      t.timestamps
    end
  end
end
