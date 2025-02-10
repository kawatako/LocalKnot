CarrierWave.configure do |config|
  # 開発環境では local (public/uploads) に保存
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    # config.enable_processing = false # 開発環境では画像処理をスキップ (オプション)
  else
    # 本番環境では fog (S3) を使用
    config.storage = :fog
    config.fog_provider = 'fog/aws' # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],     # required unless using use_iam_profile
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required unless using use_iam_profile
      region:                ENV['AWS_REGION'],            # optional, defaults to 'us-east-1'
      # host:                  's3.example.com',             # optional, defaults to nil
      # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME']           # required
    # config.fog_public     = false                                                 # optional, defaults to true
    # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  end
end