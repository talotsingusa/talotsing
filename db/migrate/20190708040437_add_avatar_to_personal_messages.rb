class AddAvatarToPersonalMessages < ActiveRecord::Migration[5.1]
  def change
    add_attachment :personal_messages, :avatar
  end
end
