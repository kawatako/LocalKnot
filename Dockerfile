# ベースとなるイメージを指定
FROM ruby:3.2.3

WORKDIR /app

ARG UID=1000
ARG GID=1000

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

ARG RAILS_ENV="production"
ARG NODE_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    NODE_ENV="${NODE_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin:/node_modules/.bin" \
    USER="ruby"

# ホスト側のソースコードをコンテナにコピー
COPY --chown=ruby:ruby . .
RUN yarn build && yarn build:css

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]