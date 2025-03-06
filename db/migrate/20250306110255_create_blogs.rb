class CreateBlogs < ActiveRecord::Migration[7.2]
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.references :thumbnail_image, foreign_key: { to_table: :images }

      t.timestamps
    end
  end
end
