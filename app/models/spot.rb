class Spot < ApplicationRecord
  has_many :questions, dependent: :nullify

    # Ransack で検索可能な属性を指定
    def self.ransackable_attributes(auth_object = nil)
      [ "name", "created_at", "updated_at" ] # name のみ許可
    end

    def self.ransackable_associations(auth_object = nil)
      [ "questions" ]
    end
end
