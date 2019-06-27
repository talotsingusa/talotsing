class RemoveColumnProfileTypeFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :profile_type, :string
  end
end
