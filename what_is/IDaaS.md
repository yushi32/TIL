## IDaaSとは

### 概要
IDaaSとは"Identity as a Service"の略称。「アイダース」と読む。<br/>
アイデンティティ（Identity）の管理をSaaSやIaaSなどと同じくクラウドで管理するサービスを指す。

簡単に言うと、一般的なWebアプリケーションで必要な認証まわりの機能（ユーザー管理・権限管理など）を提供してくれるクラウドサービス。

### 代表的なサービス
- Amazon Cognito(AWS)
- Google Cloud Identity(Google)
- Azure Active Directory(Microsoft)
- Auth 0 (Auth 0)
- Firebase Authentication(Firebase)

### IDaaSを利用するメリット
- ユーザー認証に外部サービスのアカウントを利用できる（IDフェデレーション）

GoogleやX（Twitter）などの外部サービスのアカウントを使ってログインできるようになるので、ユーザーはサービスごとにメールアドレスやパスワードを登録・管理する手間が省ける。<br/>

- 自前で認証基盤開発をしなくて済む

認証基盤を開発する上で考慮しなければならないセキュリティなどをIDaaSに丸投げできる。<br/>
また、ユーザーの機密情報をDBに保持するリスクを減らすこともできる。

- サーバー管理が不要になる

IDaaS側でデータのバックアップやサーバー・ハードウェア保守、脆弱性などへの対応をしてくれるため、サービス運用の負担が減る。

### 参考文献
- [最近流行り(?)のIDaaSについてまとめます](https://qiita.com/osak/items/28eda07e5d0183c6f99a)
- [IDaaS（Identity as a Service）とは](https://www.cybernet.co.jp/onelogin/product/idaas/)
- [クラウドID管理における「 IDフェデレーション 」とは](https://keyspider.co.jp/archives/234)
