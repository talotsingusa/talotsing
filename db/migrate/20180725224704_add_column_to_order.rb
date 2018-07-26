class AddColumnToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total_amount, :float
    add_column :orders, :status, :string, default: "pending"
  end
end
