class AddSelfAssociationForeignKeyInProductTypes < ActiveRecord::Migration[5.1]
  def change
    add_reference :product_types, :parent_product_type, index: true
  end
end
