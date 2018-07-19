class AddColumnsToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :article_number, :string
    add_column :products, :vendor_store_product_number, :string
    add_column :products, :weight, :float

  end
end
