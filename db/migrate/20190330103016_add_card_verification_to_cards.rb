class AddCardVerificationToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :card_verification, :integer
  end
end
