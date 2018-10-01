class CreateProductDesigns < ActiveRecord::Migration[5.1]
  def change
    create_table :product_designs do |t|
      t.integer :product_id
      t.integer :design_id

      t.timestamps
    end
  end
end
