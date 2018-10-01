class CreateProductClosureTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_closure_types do |t|
      t.integer :product_id
      t.integer :closure_type_id

      t.timestamps
    end
  end
end
