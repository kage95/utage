# 使用するイメージとバージョンを指定/Gemfileに記載されているバージョンに合わせる
FROM ruby:2.6.3

# yarnのインストール
# 使われているコマンドは主要なLinuxディストリビューションの1つであるUbuntuというOSのもの（簡単にいうとLinuxの流派の1つ）
# 参考：https://classic.yarnpkg.com/en/docs/install/#debian-stable（yarn公式サイト）
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# APTのパッケージリストを更新 & 各種パッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev yarn mariadb-client

# nodejsバージョン指定
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# コンテナ内での作業ディレクトリを指定
WORKDIR /utage

# ローカルのGemfileとGemgile.lockをコンテナにコピー（左側がローカル、右側がコンテナ）
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

# bundlerをインストール
RUN gem install bundler
# yarnをインストール
RUN yarn install
# 以下は一旦記述しなくてもOK/後で行うdocker-compose buildで
# babel-sourceの5.8.35がないというエラーが出たので、追加したコード
# RUN gem install babel-source -v 5.8.35
# bundlerでGemfileからgemをインストール
RUN bundle install

# ローカルのアプリ内の全てのファイルやディレクトリをコンテナの作業ディレクトリないにコピー
COPY . /utage

# entrypoint.shをコンテナの/usr/bin/にコピー
COPY entrypoint.sh /usr/bin/
# ユーザーに関わらず/usr/bin/entrypoint.shに実行権限を付与して
# シェルスクリプトファイルを実行可能
RUN chmod +x /usr/bin/entrypoint.sh
# コンテナー起動時に毎回実行されるスクリプトを追加
ENTRYPOINT ["entrypoint.sh"]

# コンテナの接続先のポートを指定
EXPOSE 3000

# イメージ実行時に起動させる主プロセスを設定
CMD ["rails", "server", "-b", "0.0.0.0"]