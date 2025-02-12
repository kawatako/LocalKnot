class Spot < ApplicationRecord
  has_many :questions, dependent: :nullify
end
