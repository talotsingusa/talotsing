class AddColumnsToBrand < ActiveRecord::Migration[5.1]
  def change
    add_column :brands, :vendor_name, :string
    add_column :brands, :vendor_email, :string
    add_column :brands, :vendor_number, :string
  end
end
