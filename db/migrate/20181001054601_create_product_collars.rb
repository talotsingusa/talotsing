class CreateProductCollars < ActiveRecord::Migration[5.1]
  def change
    create_table :product_collars do |t|
      t.integer :product_id
      t.integer :collar_id

      t.timestamps
    end
  end
end
