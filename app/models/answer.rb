class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one :question_as_best_answer, class_name: "Question", foreign_key: "best_answer_id", dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user
end
