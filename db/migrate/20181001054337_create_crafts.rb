class CreateCrafts < ActiveRecord::Migration[5.1]
  def change
    create_table :crafts do |t|
      t.string :name

      t.timestamps
    end
  end
end
