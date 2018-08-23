class CreateProductSpecifications < ActiveRecord::Migration[5.1]
  def change
    create_table :product_specifications do |t|
      t.string :spec_key
      t.string :spec_value
      t.integer :product_id

      t.timestamps
    end
  end
end
