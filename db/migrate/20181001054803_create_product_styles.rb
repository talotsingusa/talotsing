class CreateProductStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :product_styles do |t|
      t.integer :product_id
      t.integer :style_id

      t.timestamps
    end
  end
end
