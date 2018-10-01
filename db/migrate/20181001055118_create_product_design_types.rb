class CreateProductDesignTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_design_types do |t|
      t.integer :product_id
      t.integer :design_type_id

      t.timestamps
    end
  end
end
