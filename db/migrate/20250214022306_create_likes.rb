# db/migrate/xxxx_create_likes.rb
class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end

    # user_id と answer_id の組み合わせでユニーク制約
    add_index :likes, [ :user_id, :answer_id ], unique: true
  end
end
