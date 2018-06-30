class AddAvatarToCategory < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :categories, :image
  end

  def self.down
    remove_attachment :categories, :image
  end
end
