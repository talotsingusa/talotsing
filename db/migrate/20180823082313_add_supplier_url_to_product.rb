class AddSupplierUrlToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :supplier_url, :string
    add_column :products, :sale_off_percent, :integer
  end
end
