class CreateProductPatternStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :product_pattern_styles do |t|
      t.integer :product_id
      t.integer :pattern_style_id

      t.timestamps
    end
  end
end
