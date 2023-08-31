## gem 'simple_form'とは
`form with`や`form for`を使うよりも簡単にフォームを実装することができるgem。<br/>
カスタマイズも容易。

### インストール
1. Gemfileに以下の記述を追加:
```ruby
gem 'simple_form'
```
2. `$ bundle install`を実行
3. ジェネレーターを実行:
```
$ rails generate simple_form:install
```
Bootstrap や Zurb Foundation を適用させたい場合は、ジェネレーターの実行時にオプションをつける必要がある。

### 使い方
`simple_form_for`で生成したフォームには、デフォルトでラベル、ヒント、エラー、入力そのものが含まれる。


**実装例**
```ruby
# simple_form_forで実装した場合
<%= simple_form_for @user do |f| %>
  <%= f.input :username %>
  <%= f.input :password %>
  <%= f.button :submit %>
<% end %>

# form_withで実装した場合
<%= form_with model: @user do |f| %>
  <%= f.label :username %>
  <%= f.text_field :username %>
  <%= f.label :password %>
  <%= f.password_field :password %>
  <%= f.submit %>
<% end %>
```

<br/>

**i18n**<br/>
フォームを i18n 化するためには、以下のようなロケールファイルを作成する。
```ruby
en:
  simple_form:
    labels:
      user:
        username: 'User name'
        password: 'Password'
    hints:
      user:
        username: 'User name to sign in.'
        password: 'No special characters, please.'
    placeholders:
      user:
        username: 'Your username'
        password: '****'
    include_blanks:
      user:
        age: 'Rather not say'
    prompts:
      user:
        role: 'Select your role'
```

### オプション
オプションは属性名の後ろにカンマ区切りで指定する。
```ruby
<%= f.input :username, label: 'アカウント名' %>
```

- クラス、IDの指定
```ruby
class: 'form-control'
id: "post-#{@post.id}"
```
- ラベル名の変更・非表示
```ruby
label: 'アカウント名'　# 変更
labal: false　　　　　　   # 非表示
```
- プレースホルダ
  
フォームの中に薄く表示される文字を表示する。
```ruby
placeholder: 'パスワード'
```
- ヒント
  
フォームの外側に表示される、入力内容についてのヒントや注意書きを表示する。
```ruby
hint: 'xx文字以上、XX文字以内'
```
- セレクトボタンで初期選択を指定する
```ruby
include_blank: true    # 初期選択を空にする
include_blank: 'その他' # 初期選択で文字列を指定する場合
```
- ファイル送信フォームに変更
```ruby
as: :file
```
- カレンダーで日付指定
```ruby
as: :date_time_picker
```
- エラーメッセージの表示・非表示
```ruby
error: '半角英数字で入力してください'　# 表示する内容を指定
error: false                   # 非表示
```
- 任意のHTML属性を指定
  
例えば、画像を複数投稿できるようにしたい場合は､そのまま`multiple: true`を付与するのではなく､`input_html`の中で指定する｡
```ruby
input_html: { multiple: true }
```
### simple formを使う利点
1. ラベルの記述が不要
  
`<%= f.input :username %>`のような一行で、ラベルも含んだフォームを生成してくれる。<br/>
ラベルは i18n で日本語訳を記述しておけば、それを適用してくれる。

2. フィールドの指定も不要
  
カラムのデータ型に応じたフィールドを自動で判断して生成してくれる。

3. 他のgemと組み合わせてフォームをカスタマイズできる
  
`enum help` gem と組み合わせてラジオボタンを実装したり、 `country_select` gem と組み合わせて国選択を実装することなどが可能。

### 参考文献
- [Github](https://github.com/heartcombo/simple_form)
- [[Rails] Simple_form gem](https://zenn.dev/yusuke_docha/articles/1fa77e0cfd54d9)
- [【Rails】simple_form使い方基礎](https://qiita.com/A__Matsuda/items/dbf4da62ab9951b67aa9)
- [【Rails】簡単にformが作成できるsimple_form](https://opiyotan.hatenablog.com/entry/gem_simple_form)
