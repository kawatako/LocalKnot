class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable, :trackable
  has_one :profile, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
end
