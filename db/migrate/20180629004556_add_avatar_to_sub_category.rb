class AddAvatarToSubCategory < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :sub_categories, :image
  end

  def self.down
    remove_attachment :sub_categories, :image
  end
end
