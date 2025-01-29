source "https://rubygems.org"

gem "rails", "~> 7.1.3"
# Ruby on Rails フレームワーク本体
gem "propshaft"
# Rails のモダンなアセットパイプライン (アセットの管理と配信)
gem "pg", "~> 1.1"
# PostgreSQL データベース用のアダプタ
gem "puma", ">= 5.0"
# Puma Web サーバー (アプリケーションサーバー)
gem "jsbundling-rails"
# JavaScript のバンドルとトランスパイル
gem "turbo-rails"
# Hotwire の Turbo (高速なページ遷移を実現)
gem "stimulus-rails"
# Hotwire の Stimulus (JavaScript フレームワーク)
gem "cssbundling-rails"
# CSS のバンドルと処理
gem "jbuilder"
# JSON API を簡単に構築するための gem
gem "tzinfo-data", platforms: %i[windows jruby]
# タイムゾーン情報 (Windows や JRuby で必要)
gem "solid_cache"
# データベースバックエンドのキャッシュストア (Rails.cache)処理結果をキャッシュして、アプリケーションを高速化
gem "solid_queue"
# データベースバックエンドのジョブキュー (Active Job)時間のかかる処理を非同期に実行して、ユーザー体験を向上させる
gem "solid_cable"
# データベースバックエンドの WebSocket 接続管理 (Action Cable)Action Cable のアダプターを PostgreSQL データベースで置き換える
gem "bootsnap", require: false
# アプリケーションの起動を高速化するための gem
gem "kamal", require: false
# Docker を使用したアプリケーションのデプロイを簡素化するツール
gem "thruster", require: false
# Puma に HTTP アセットのキャッシュ、圧縮、X-Sendfile アクセラレーションを追加
gem "tailwindcss-rails", "~> 4.0.0.rc1", github: "rails/tailwindcss-rails", branch: "main"
# Tailwind CSS を Rails で使用するための gem

group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  # デバッガ (Ruby のデバッグを支援)
  gem "brakeman", require: false
  # セキュリティ脆弱性を検出する静的解析ツール
  gem "rspec-rails", require: false
  # RSpec テストフレームワーク
  gem "pry-byebug"
  # デバッグ用コンソール (Pry) と byebug の連携
  gem "pry-doc"
  # Pry で Ruby のドキュメントを参照できるようにする
  gem "pry-rails"
  # Rails コンソールで Pry を使用
  gem "rubocop-faker"
  # Faker gem に特化した RuboCop 拡張 (偽データの生成)
  gem "rubocop-rails", require: false
  # Rails に特化した RuboCop 拡張
  gem "rubocop-rspec", require: false
  # RSpec に特化した RuboCop 拡張
  gem "rubocop-capybara", require: false

  gem "rubocop-rspec_rails", require: false
end

group :development do
  gem "web-console"
  # 例外発生時に Web ブラウザ上でコンソールを表示
end

group :test do
  gem "capybara"
  # 統合テストフレームワーク (ブラウザ操作の自動化)
  gem "selenium-webdriver"
  # Selenium WebDriver (ブラウザの自動操作)
end
