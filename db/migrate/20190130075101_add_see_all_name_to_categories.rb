class AddSeeAllNameToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :see_all_name, :string
  end
end
