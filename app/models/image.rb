class Image < ApplicationRecord
  has_one_attached :file
  belongs_to :user

  validate :validate_file_type_and_size

  private

  def validate_file_type_and_size
    return unless file.attached? # ファイルが添付されていない場合はチェックしない

    # ファイルタイプのチェック
    unless [ "image/png", "image/jpg", "image/jpeg", "image/gif" ].include?(file.content_type)
      errors.add(:file, :invalid_content_type, message: "は許可されていないファイルタイプです")
    end

    # ファイルサイズのチェック
    if file.blob.byte_size > 5.megabytes
      errors.add(:file, :file_size_too_big, message: "は5MBより大きいサイズです")
    end
  end
end
