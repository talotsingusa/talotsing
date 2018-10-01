class CreateProductSleeveTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_sleeve_types do |t|
      t.integer :product_id
      t.integer :sleeve_type_id

      t.timestamps
    end
  end
end
