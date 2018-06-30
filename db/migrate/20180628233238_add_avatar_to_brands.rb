class AddAvatarToBrands < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :brands, :logo
  end

  def self.down
    remove_attachment :brands, :logo
  end
end
