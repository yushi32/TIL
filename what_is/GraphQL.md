## GraphQLとは

### 概要
> GraphQLとは API のために作られたクエリ言語であり、既存のデータに対するクエリを実行するランタイムです。
> 理解できる完全な形で API 内のデータについて記述します。
> GraphQL を利用すれば、クライアント側から必要な内容だけを問い合わせられると共に、漸次的に API を進化させることが容易になり、強力な開発者ツールを実現できます。
> via 公式ドキュメント

GraphQLは、元々Facebook（Meta）社のプロジェクト。<br/>
モバイルアプリケーションでは、ネストされたデータ・相互にリンクされたデータを大量に扱うため、アプリケーションのパフォーマンスを向上するために必要なリソースだけにアクセスしなければいけないという背景から生まれた。

GraphQLのクエリは、グラフ理論というノード(頂点)の集合とエッジ(辺)の集合で構成されるグラフの数学の理論に似ている。

### つまり？
- GraphQLは、APIから必要なデータを受け取るためのクエリ言語であり
- サーバーサイドで既存のデータを使って送られてきたクエリの処理もしている
- GraphQLを使えば、クライアント側から必要なデータだけをリクエストできる

### REST APIの問題点
REST API（RESTful API）は、あるエンドポイント（URI）にリクエストを送ると対応したレスポンスが返ってくるというもの。<br/>
この時、レスポンスの中には不必要なデータが含まれる場合がある。

例えば、`/users/1`にリクエストを送ると、idが1のuserのデータがレスポンスとして返ってくる。<br/>
このuserに`name`, `age`, `job`, `height`, `weight`が含まれるとする。<br/>
しかし、クライアント側で表示したい情報が`name`と`job`だった場合、他の情報は不必要だったことになる。

大量のデータを扱う場合、上記のような不必要なデータが大量に存在するとパフォーマンスの低下につながってしまう。<br/>
GraphQLではこれを改善し、必要なデータだけをリクエストすることができる。


### 参考文献
- [GraphQL入門](https://zenn.dev/yoshii0110/articles/2233e32d276551#restful-api)
- [GraphQLを徹底解説する記事](https://zenn.dev/nameless_sn/articles/graphql_tutorial)
- [GraphQLとは？メリットや概要を入門ガイドで学ぶ](https://circleci.com/ja/blog/introduction-to-graphql/)
- [これを読めばGraphQL全体がわかる。GraphQLサーバからDB、フロントエンド構築](https://reffect.co.jp/html/graphql/)
- [GraphQLとRESTの比較─知っておきたい両者の違い](https://kinsta.com/jp/blog/graphql-vs-rest/)
- [GraphQLとは何でしょうか。](https://hasura.io/learn/ja/graphql/intro-graphql/what-is-graphql/)
