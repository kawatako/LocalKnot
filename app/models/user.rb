class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable, :trackable
  has_one :profile, dependent: :destroy
end
