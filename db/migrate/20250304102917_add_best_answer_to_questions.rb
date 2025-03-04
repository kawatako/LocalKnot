class AddBestAnswerToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_reference :questions, :best_answer, foreign_key: { to_table: :answers }, null: true
  end
end
