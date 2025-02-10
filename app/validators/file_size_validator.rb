# app/validators/file_size_validator.rb
class FileSizeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? # ファイルがアップロードされていない場合はスキップ

    max_size = options[:less_than]
    if value.size > max_size
      record.errors.add(attribute, :too_large, count: max_size / 1.megabyte)
    end
  end
end
