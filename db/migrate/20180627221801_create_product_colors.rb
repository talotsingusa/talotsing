class CreateProductColors < ActiveRecord::Migration[5.1]
  def change
    create_table :product_colors do |t|
      t.integer :product_id
      t.integer :color_id

      t.timestamps
    end
  end
end
