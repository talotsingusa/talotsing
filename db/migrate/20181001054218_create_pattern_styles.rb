class CreatePatternStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :pattern_styles do |t|
      t.string :name

      t.timestamps
    end
  end
end
