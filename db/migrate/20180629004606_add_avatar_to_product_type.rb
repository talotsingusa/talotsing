class AddAvatarToProductType < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :product_types, :image
  end

  def self.down
    remove_attachment :product_types, :image
  end
end
