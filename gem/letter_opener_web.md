## letter_opener_webとは
letter_opener_web は、Ruby on Rails アプリケーションで開発中のメールをブラウザ上で確認するためのgem。

### 概要
開発環境でメール送信機能を使ってメールを送った場合、実際にメールを送信せず、ブラウザ上で確認することができる。  
開発中のアプリケーションでメールのレイアウトや内容を確認するのに便利。  
通常のメール送信処理を利用する際に、メールが実際に送信されるのを防ぎ、代わりに開発者によるプレビューを提供する。  

### 特徴
・メールのプレビュー画面をブラウザで確認できる  
・メールの送信先や件名、本文なども表示される
・送信されたメールの内容やレイアウトを確認出来る
・メールのリンクや添付ファイルなどもブラウザ上で確認出来る

### インストールと使用方法
Gemfileファイルの`group :development`ブロック内に以下の行を追加:
```
gem 'letter_opener_web'
```
ターミナルで bundle install を実行してインストール。
config/routes.rbに以下の行を追加：
```
if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
```
config/environments/development.rbに以下の行を追加:
```
config.action_mailer.delivery_method = :letter_opener_web
```
Railsサーバーを起動し、メール送信機能を使った際にブラウザ上でメールのプレビューを確認出来るようになる。
アクセスURLは、localhost:3000/letter_opener。


### 注意点
・letter_opener_web は開発環境でのみ使用されるべきであり、本番環境でのメール送信には使用されない。
・メール送信機能を実装するには、RailsのActive Mailerを利用する。






