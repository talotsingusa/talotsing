class CreateShippings < ActiveRecord::Migration[5.1]
  def change
    create_table :shippings do |t|
      t.string :name
      t.string :cntry_name
      t.string :street_address_one
      t.string :street_address_two
      t.string :state
      t.string :city
      t.string :postal_code
      t.string :mobile
      t.integer :user_id

      t.timestamps
    end
  end
end
