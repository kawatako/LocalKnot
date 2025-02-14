class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likes, dependent: :destroy
  has_many :likes_users, through: :likes, source: :user
end
