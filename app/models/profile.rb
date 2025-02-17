# app/models/profile.rb
class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  enum gender: { male: 0, female: 1, other: 2 }, _prefix: true

  # カスタムバリデーターを使用
  validates :avatar, file_size: { less_than: 5.megabytes },
                     file_content_type: { allow: [ "image/jpeg", "image/png", "image/gif" ] }

  # enum gender の値を、国際化対応 (i18n) された文字列に変換するためのメソッド
  def gender_i18n
    I18n.t("activerecord.enums.profile.gender.#{gender}")
  end
end
