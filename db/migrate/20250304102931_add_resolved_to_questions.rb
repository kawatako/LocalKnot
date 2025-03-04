class AddResolvedToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_column :questions, :resolved, :boolean, default: false, null: false
    add_index :questions, :resolved
  end
end
