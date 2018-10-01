class CreateCollars < ActiveRecord::Migration[5.1]
  def change
    create_table :collars do |t|
      t.string :name

      t.timestamps
    end
  end
end
