class CreateSpots < ActiveRecord::Migration[7.2]
  def change
    create_table :spots do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :spots, :name, unique: true
  end
end
