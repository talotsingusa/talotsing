class CreateShippingPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_prices do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
