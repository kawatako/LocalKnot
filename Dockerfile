# 開発環境用のステージ
ARG UID=1000
ARG GID=1000
FROM ruby:3.2.3 AS development

WORKDIR /app

# 環境変数 LANG を設定。文字エンコーディングを C.UTF-8 に設定します。
ENV LANG C.UTF-8

# 環境変数 TZ を設定。タイムゾーンを Asia/Tokyo に設定します。
ENV TZ Asia/Tokyo

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential curl git libpq-dev
# Node.js と Yarn をインストール
RUN curl -sSL https://deb.nodesource.com/setup_18.x | bash - \
  && curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && groupadd -g "${GID}" ruby \
  && useradd --create-home --no-log-init -u "${UID}" -g "${GID}" ruby \
  && mkdir /node_modules && chown ruby:ruby -R /node_modules /app

# ユーザーをrubyに変更
USER ruby

# Railsをインストール
RUN gem install rails -v '7.1.3'

# ホスト側の Gemfile と Gemfile.lock をコンテナにコピー
COPY --chown=ruby:ruby Gemfile* ./
RUN bundle config set --local without 'production' \
    && bundle install --jobs "$(nproc)"

COPY --chown=ruby:ruby package.json *yarn* ./
RUN yarn install

# npx のバージョン確認 (デバッグ用)
RUN npx -v

# tailwindcss の存在確認 (デバッグ用)
RUN yarn list | grep tailwindcss

# ホスト側のソースコードをコンテナにコピー
COPY --chown=ruby:ruby . .

# yarn build を実行
RUN yarn build && yarn build:css

# 本番環境用のステージ
FROM ruby:3.2.3 AS production

WORKDIR /app

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y --no-install-recommends libpq-dev curl
RUN curl -sSL https://deb.nodesource.com/setup_18.x | bash - \
  && curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y --no-install-recommends nodejs yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean

# Railsをインストール
RUN gem install rails -v '7.1.3'

COPY --from=development /usr/local/bundle/ /usr/local/bundle/
COPY --from=development /app/public/assets /app/public/assets
COPY --from=development /app/node_modules /app/node_modules
COPY --from=development /app /app

# プロジェクトで使用する環境変数を設定
ARG RAILS_ENV="production"
ARG NODE_ENV="production"
ARG RACK_ENV="production"
ARG RAILS_SERVE_STATIC_FILES="true"
ARG RAILS_LOG_TO_STDOUT="true"

ENV RAILS_ENV="${RAILS_ENV}" \
    NODE_ENV="${NODE_ENV}" \
    RACK_ENV="${RACK_ENV}" \
    RAILS_SERVE_STATIC_FILES="${RAILS_SERVE_STATIC_FILES}" \
    RAILS_LOG_TO_STDOUT="${RAILS_LOG_TO_STDOUT}" \
    PATH="${PATH}:/app/node_modules/.bin"

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]