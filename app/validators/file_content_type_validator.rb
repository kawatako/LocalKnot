# app/validators/file_content_type_validator.rb
class FileContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? # ファイルがアップロードされていない場合はスキップ

    allowed_types = options[:allow]
    unless allowed_types.include?(value.content_type)
      record.errors.add(attribute, :content_type_invalid, allowed_types: allowed_types.join(", "))
    end
  end
end
