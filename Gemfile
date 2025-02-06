source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby のバージョンを指定
ruby "3.2.3"

# Rails フレームワーク本体
gem "rails", "~> 7.2.1"

# PostgreSQL 用データベースアダプタ
gem "pg", "~> 1.1"

# Puma Web サーバー
gem "puma", "~> 6.0"

# JavaScript のビルドを管理
gem "jsbundling-rails"

# ページ遷移を高速化する Hotwire の一部
gem "turbo-rails"

# 軽量な JavaScript フレームワークである Hotwire の一部
gem "stimulus-rails"

# CSS のビルドを管理
gem "cssbundling-rails"

# JSON API を構築するための DSL
gem "jbuilder"

# Redis クライアント
gem "redis", "~> 5.0"

# Windows で必要となるタイムゾーン情報
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# バックグラウンドジョブ処理
gem "sidekiq", "~> 7.0"

# ユーザー認証機能
gem "devise"

# Devise の国際化対応
gem "devise-i18n"

# ページネーション機能
gem "kaminari"

# 検索機能
gem "ransack"

# 起動高速化
gem "bootsnap", require: false

# 開発・テスト環境用
group :development, :test do
  # デバッグ用ツール
  gem "debug", platforms: %i[mri mingw x64_mingw]

  # コード静的解析ツール
  gem "rubocop-capybara", require: false
  gem "rubocop-faker", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rails-omakase", require: false

  # RSpec テストフレームワーク
  gem "rspec-rails"

  # システムテスト用
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers", "~> 5.0"

  # テストデータ作成
  gem "factory_bot_rails"

  # テストデータクリーンアップ
  gem "database_cleaner"
end

# 開発環境用
group :development do
  # 例外発生時のコンソール表示
  gem "web-console"

  # アプリケーション起動高速化 (jsbundling-rails, cssbundling-railsを使う場合、無効化することを推奨)
  # gem "spring"
  # spring使用時、listen gemを使ってファイルの変更を検知する
  # gem "spring-watcher-listen", "~> 2.0.0"
  # Rails アプリケーションのセキュリティ脆弱性を静的に解析するツ
  gem "brakeman"

  # 開発環境でメールをプレビュー
  gem "letter_opener", "~> 1.9.0"
  gem "letter_opener_web", "~> 2.0"
end
# gem "rubocop-rspec_rails", "~> 2.30", groups: [:development, :test]
