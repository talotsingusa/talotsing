class ChangeStatusFromStringToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :status, :string
    add_column :orders, :status, :integer
  end
end
