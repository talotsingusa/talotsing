class AddSeeAllToSubCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :sub_categories, :see_all, :boolean, default: false
  end
end
