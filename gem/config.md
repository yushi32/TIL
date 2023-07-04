## gem "config"とは

`gem "config"` は、RubyGems の Gem の設定情報を管理するためのライブラリ。
アプリケーションの設定情報を一元管理し、環境ごとに分けて管理することができる。

### 概要

- `gem "config"` を使用すると、アプリケーションの設定情報を簡単に管理することができる。
- 設定情報は、ホスト名、ポート番号、API キーなど、アプリケーションの動作に必要なパラメータを含むことができる。
- `gem "config"` を使用することで、これらの設定情報を一元管理し、アプリケーション内で簡単にアクセスできる。

### 主な機能

以下は、`gem "config"` の主な機能:

- 設定ファイルの作成と管理: アプリケーションの設定情報を YAMLファイルなどにまとめて管理する。
- 環境ごとの設定: 開発環境、本番環境など、異なる環境ごとに設定情報を分けて管理できる。
- 設定値の読み込みとアクセス: 設定ファイルから設定値を読み込み、アプリケーション内で簡単にアクセスできる。

### 定数管理の意義

1. 可読性と保守性の向上:定数を使用することで、設定情報やパラメータが直感的に理解できる。また、変更が必要な場合も定数のみを修正すれば良いため、保守性が向上する。
2. 柔軟な設定変更: 定数管理により、環境ごとに異なる設定情報を簡単に切り替えることが可能になる。開発環境と本番環境で異なる設定を持つ場合、定数管理を利用することで簡単に切り替えられる。
3. セキュリティの向上: 重要な設定情報や機密情報を定数として管理することで、ソースコード上に直接記述する必要がなくなる。定数管理は機密情報の保護に役立つ。
<br/>
定数管理は、設定ファイルや環境変数、外部ライブラリなどを活用して行うことが一般的。<br/>
`gem "config"` は、その一つの手段として利用できる。


### インストール

Gemfile に以下の行を追加:

```ruby
gem "config"
```
`$ bundle install`を実行してインストール。  
インストール後、`$ rails g config:install`を実行すると、以下のファイルとディレクトリが生成され、.gitignoreに追記される。
```
config/initializers/config.rb
config/settings.yml
config/settings.local.yml
config/settings
config/settings/development.yml
config/settings/production.yml
config/settings/test.yml
```

### 生成された各ファイルの役割

| ファイル名                           | 役割                                       |
|--------------------------------------|--------------------------------------------|
| config/initializers/config.rb         | configの設定ファイル                         |
| config/settings.yml                   | すべての環境で利用する定数を定義               |
| config/settings.local.yml             | ローカル環境のみで利用する定数を定義            |
| config/settings/development.yml       | 開発環境のみで利用する定数を定義               |
| config/settings/production.yml        | 本番環境のみで利用する定数を定義               |
| config/settings/test.yml              | テスト環境のみで利用する定数を定義               |

### 定数の設定と使い方
- 例えば、development環境で、定数を定義する場合。
```ruby
# config/settings/development.yml
host:
  domain: 'localhost:3000'
  email: 'example@example.com'
```
<br/>

- 呼び出し方
```
Settings.host.domain #=> "localhost:3000"
Settings.host.email #=> "example@example.com"
```


---



