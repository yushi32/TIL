## gem "enum_help"とは

gem "enum_help"は、Railsアプリケーションで列挙型(enum)を扱う際に便利なヘルパーメソッドを提供するgem。<br/>
列挙型を定義する際に、データベース内での値とそれに対応する表示名を簡単に管理することができる。

### 主な機能

- 列挙型(enum)の定義と管理を簡素化する。
- 列挙型の各値に対応する表示名を翻訳ファイルで管理できる。
- 列挙型の値に対して、簡単に表示名や値の変更、取得ができるようになる。

### インストール方法
`Gemfile`に以下の行を追加:

   ```ruby
   gem 'enum_help'
   ```
コンソールで以下のコマンドを実行:
```shell
bundle install
```
`config/locales/enum_help.ja.yml`など、翻訳ファイルを作成し、列挙型の値と表示名の対応を設定する。

### 使用方法
例えば、Userモデルでrole列挙型を定義する場合:
```ruby
class User < ApplicationRecord
  enum role: { general: 0, admin: 1 }
end
```
ビューファイルやコントローラなどで、列挙型の値に対応する表示名を取得したい場合は、role_i18nメソッドを使用する。<br/>
例:
```ruby
user.role = 1
user.role_i18n # => '管理者'
```

role_i18nメソッドは、定義した列挙型の各値に対応する表示名を返す。

### まとめ
gem "enum_help"を使用することで、Railsアプリケーションで列挙型を管理する際の手間を減らし、翻訳ファイルを活用した表示名の取得を容易にすることが可能。

 
