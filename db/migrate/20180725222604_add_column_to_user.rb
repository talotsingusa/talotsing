class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :default_source, :string
  end
end
