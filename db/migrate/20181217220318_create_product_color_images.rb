class CreateProductColorImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_color_images do |t|
      t.string :color
      t.integer :product_id

      t.timestamps
    end
  end
end
