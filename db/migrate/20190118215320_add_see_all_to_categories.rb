class AddSeeAllToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :see_all, :boolean, default: false
  end
end
