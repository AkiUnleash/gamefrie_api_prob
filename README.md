# gamefrie_prob
げむふれ！WebAPIを起動するための、本番環境を構築するDocker。

## Dependency
DockerFile及びDoker-composeより、以下を構築する。
- CentOS 8
- Ruby 2.7.2
- Rails 6.0.3.4
- Nginx 1.14.1
- Unicorn

## Setup
1. Gitをダウンロード [ git clone https://github.com/AkiUnleash/gamefrie_prob.git ]
2. Dockerの起動(数分を要する) [ docker-compose up -d ]
3. 起動したコンテナに入る [ docker exec -it gamefrieapi_prob_web_1 bash ]
4. bunlderのインストール [ gem install bunlder ]
5. Gemfile内のgemをインストール [ bundle install ]
6. Unicornの起動 [ rake unicorn:start ]
7. 確認 [ http://localhost:3000/profiles ]

※元となるWebAPIのソース（[AkiUnleash/gamefrie_api_dev](https://github.com/AkiUnleash/gamefrie_api_dev)）

## Usage
以下にアクセスするとJsonでデータを取得できる。
（POST／PUT／DELETEも可能）

プロフィール [ http://localhost:3000/profiles ]
アカウント [ http://localhost:3000/accounts ]
ジェンダー [ http://localhost:3000/genders ]
ダイアリー [ http://localhost:3000/diaries ]


## License

## Authors
AkiUnleash

## References