class AddSelfAssociationForeignKey < ActiveRecord::Migration[5.1]
  def change
    add_reference :sub_categories, :parent_sub_category, index: true
  end
end
