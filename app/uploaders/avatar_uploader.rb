class AvatarUploader < CarrierWave::Uploader::Base
  # 画像処理に MiniMagick を使用 (ImageMagick が必要)
  include CarrierWave::MiniMagick

  # 開発環境では local (public/uploads) に保存
  # 本番環境では fog (S3) に保存
  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # 保存先ディレクトリ (環境によって変わる)
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # デフォルト画像のパス (必要に応じて)
  def default_url(*args)
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_')) # assets pipeline を使う場合
    "/assets/default_avatar.png" # public/assets/images に default_avatar.png を配置
  end

  # リサイズ (必要に応じてバージョンを追加)
  version :thumb do
    process resize_to_fill: [100, 100] # 100x100 にリサイズ (はみ出る部分はカット)
  end

  version :display do
    process resize_to_limit: [400, 400] # 400x400 にリサイズ (はみ出さないように調整)
  end

  # 許可する拡張子
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # ファイル名を変更 (必要に応じて)
  # def filename
  #   "something.jpg" if original_filename
  # end
end