
# bestpraとは
![説明ページ](/design/img/about-page.gif)
<!-- 実際に使用した動画や背景画像を差し込み -->
bestpraとは、**サッカーの練習メニューを共有するサービスとなります。**  
練習メニューを考える時間を練習に費やす。自分の長所を伸ばす、短所を補うような練習メニューを見つける  
そんなサービスを心がけております。  
<br />

<!-- こちらからご覧ください(作成中)   -->
<!-- URL添付 -->
<!-- [サイトURL](https://app.bestpra.com/about) -->

<br />

# 作成背景
**「指導者のサッカー経験に左右されないで、目的を達成するための練習を考えるきっかけを作りたい」**  
- 私は高校生の時、顧問の先生がサッカー経験者ではななかったため、自分たちで練習メニューを考えないといけない環境に身を置いておりました。
- それはそれで楽しかったのですが、練習メニューは小学校、中学校で習った練習メニューであり、高校生に適したもの、自分たちにあった練習メニューかどうか分かりませんでした。
- そんな不安もあってか、もう一つ勝てば都大会に出場できるという場面で惜敗してしまいました。
- 自分たちに責任があるとはいえ、練習メニューにも問題があったことは確かだと感じています。
- そんな私のように考えてしまう人を減らしたい。もっと気軽に練習メニューを共有することができればもっと日本のサッカーレベルは上がるのではないか。そんな気持ちで作成しました。

<br />

# インフラ構成図
![インフラ構成図](/design/infra.svg)

<br />

# ER図
![ER図](/design/img/ER.png)

# 使用技術
| バックエンド
----|
| Ruby 3.1.2 |
| Rails 7.0.4 |
| MySQL 8.0.31|
| Nginx/puma |
| RoboCop |
| Rspec |
<br />

| フロントエンド
----|
| Nuxt.js 2.15.8(SSR mode)  |
| Vuetify 2.6.12 |
| axios |
| eslint/prettier(静的解析、フォーマッター) |
| Jest |
<br />


| インフラ
----|
| docker / docker-compose  |
| Circleci(デプロイ完成後GithubActionsへ移行) |
| GithubActions |
| AWS (Route53,ALB,VPC,subnet,ECR,ECS,RDS,ACM,SSM,cloudWatch) |
| terraform(インフラをコード化) |
<br />


# 機能一覧
- JWT
  - 新規作成
  - ログイン機能
  - ログアウト機能
  - サイレントリフレッシュでセッション維持
- ユーザー
  - 閲覧
  - 編集
  - 削除
- フォローフォロワー機能
  - 閲覧
- 練習メニュの記事
  - 作成
  - 閲覧
  - 編集
  - 削除
  - いいね機能
- 練習メニュへのコメント
  - 作成
  - 削除
- 通知機能
  - 記事のいいね時
  - 記事のコメント時
  - フォロー時
- 検索
  - 記事のタイトル内容から検索
  - ラベルから記事を検索
  - タグから記事を検索
<br />
<br />

# 工夫した点
## バックエンド
- バックエンドとフロントエンドを完全に分離し、API通信を実装
- N+1問題を考慮した実装
- リアルなseedデータを作成
- Ckeditorから送られてくるデータをsanitize処理しxss対策を実施

<br />

## フロントエンド
- SEOや画面描写速度を考えてSSR(universal)モードを採用
- 学生やコーチなど幅広い年齢層でも使いやすいシンプルで分かりやすいUIを採用
- vuexを活用し、リアルタイムで画面に反映
- ログイン状態によった画面遷移を実施
- Ckeditorを使用してリッチテキストを使用
- 全てのページでレスポンシブデザインを実装
- aboutページを作成し、使い方や使ったイメージを想像できるように実装
- prettierを利用して、読みやすいコードを意識

<br />

## インフラ
- Dockerを採用することで複数人でも同じ環境を構築できるように
- Dockerと相性の良いAWS(ECS Fargate)を採用
- Github Actionsを用いてCI/CDパイプラインを構築
- terraformによるインフラのコード化


<!--
ファイルの命名規則
・component   => PascalCase
・その他       => kebab-case
・DOM         => kebab-case

props => kebab-case ->:kebak-case props[pascalCase]
emit => kebab-case -> this.$emit('my-emit')
 -->