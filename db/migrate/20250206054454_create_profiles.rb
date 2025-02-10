class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :user_name
      t.text :introduction
      t.date :birthdate
      t.integer :gender
      t.string :website

      t.timestamps
    end
  end
end
