## factory botとは
RSpecや他のテストフレームワークで使用されるRubyのライブラリ。<br/>
テストケースで必要なオブジェクトやデータの生成を簡単に行うことができる。

### インストール
Gemfileの`group :test`ブロック内に以下の行を追加：
```ruby
gem 'factory_bot_rails'
```
`$ bundle install`を実行して、インストール。

### データの定義
- 作成したいデータのモデルを指定して、工場（ファクトリ）を作る。
```shell
$ rails g factory_bot:model user
```
- `spec/factories/users.rb`が作成されるので、記述を追加する。
```ruby
FactoryBot.define do
  factory :user do # どのモデルの工場かを定義して、ブロック内で属性を定義する
    name { "しんのすけ" }
    age { 5 }
    height { 106 }
  end
end
```
- 重複した値のデータを作りたくない場合は`sequence`を使う。
```ruby
FactoryBot.define do
  factory :user do
    name { "しんのすけ" }
    sequence(:email) { |n| "shinchan_#{n}@kasukabe.com" }
  end
end

# コンソールで実行すると、連番でデータが生成されることが確認できる
generate :email #=> "shinchan_1@kasukabe.com"
generate :email #=> "shinchan_2@kasukabe.com"
```
- `sequence`の他の書き方
```ruby
# ブロックを渡してるだけなので、do endでも書ける
sequence(:email) do |n|
  "shinchan_#{n}@kasukabe.com"
end

# 連番にしたい部分が末尾の場合に限り、この書き方も可能
sequence(:title, "title_1")
# 下と同じ
sequence(:title) { |n| "title_#{n}" }
```

### データの作成
- createメソッド
  作成したオブジェクトを実際にDBに保存するメソッド。<br/>レコードを操作するテストケースで使用される。
```ruby
user = FactoryBot.create(:user)
or
user = create(:user)

# 工場で設定した初期値を上書きしたい場合：
user = FactoryBot.create(:user, name: 'masaokun')
user = create(:user, name 'masaokun')
```
- buildメソッド
  DBに保存せずにオブジェクトを作成するためのメソッド。<br/>テストのためだけに使う一時的なオブジェクトを生成したい場合に使われる。
```ruby
user = FactoryBot.build(:user)
user = build(:user)

# create同様、初期値の上書きも可能
user = FactoryBot.build(:user, name: "kazamakun")
user = build(:user, name: "kazamkun")
```
