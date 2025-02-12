class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.references :spot, null: false, foreign_key: true
      t.references :category, foreign_key: true, null: true

      t.timestamps
    end
  end
end
