# form_withメソッド

### 概要

- HTMLのformタグ生成するヘルパーメソッド
- 入力フォームを実装する
- Rails5.1系から推奨されていて、form_tagとform_forを統合したもの

### 使い方

```ruby
<%= form_with model: オブジェクト, do |f| %>
  <%= f.label :送信先の属性名 %>
  <%= f.text_field :送信先の属性 %>
  <%= f.submit 'リンクテキスト' %>
<% end %>
```

- 投稿作成フォームの例：

```ruby
<%= form_with model:@post local: true do |f| %>
  <div>
    <%= f.label :title %>
    <%= f.text_field :title %>
  </div>
  <div>
    <%= f.label :content %>
    <%= f.text_field :content %>
  </div>
  <div>
    <%= f.submit '投稿' %>
  </div>
<% end %>
```
上記のform_withタグの記述から以下のHTMLが生成される
```html
<form action="/posts" method="post">
  <div>
    <label for="post_title">タイトル</label>
    <input type="text" name="post[title]", id="post_title" />
  </div>
  <div>
    <label for="post_content">本文</label>
    <textarea name="post[content]", id="post_content"></textarea>
  </div>
  <div>
    <input type="submit", name="commit", value="投稿">
  </div>
</form>
```

### フィールドの種類

ローカル変数とヘルパーメソッドを組み合わせてフォーム要素を生成する

主なヘルパーメソッド：

- text_field：一行のテキストボックス
- textarea：テキストエリア
- password_field：パスワード入力ボックス（入力したテキストがアスタリスクなどに置き換えて表示される）
- hidden_field：隠しフィールド、ビューに表示されない
- submit：送信ボタン

その他にも多くのヘルパーメソッドを利用できる。

参照：[https://railsguides.jp/form_helpers.html#その他のヘルパー](https://railsguides.jp/form_helpers.html#%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AE%E3%83%98%E3%83%AB%E3%83%91%E3%83%BC)

### オプションについて

- modelオプション

指定したモデルオブジェクトの値がフォームに自動入力される。

edit画面を考えると分かりやすい。

各編集ページで初期値としてDBに保存されている値が代入されている。

- urlオプション

フォームの送信先を指定する

使われるのは主に次の2つのパターン：

1. モデルとフォームが紐づかない場合（例: ログインフォーム: user_sessions）
2. createやupdateを行うコントローラがモデルと単純に紐づかない場合（例: model: @user と設定したが、 members_controller に処理が遷移して欲しい場合）

- methodオプション

HTTPメソッドを指定する。

link_toメソッドと異なり、turbo_methodで指定する必要はない。

- localオプション

ajax通信のオンオフを設定する。

Rails6.1からはデフォルトが`local: true`（同期通信）になったので、ajax通信を行いたい場合は明示的に`local: false`を指定する

- scopeオプション

送信するパラメータのキーを指定する。

例えば、`model: @user, scope: user`とすると、送信するパラメータは`user`というキーの中にまとめられ、params[:user]でアクセスできるようになる。

name属性に対応するフィールド（`text_field :name`）から送信されたパラメータはparams[:user][:name]で取得できる。

### form_withメソッドの便利な機能

form_withメソッドは、modelオプションを指定した場合、インスタンスの状態によってリクエストを送るアクションを自動で判断してくれる。

1. インスタンスが空の場合 → createアクション
2. インスタンスに値が入っている場合 → updateアクション
    - 2.の場合、インスタンスが持っている値を初期値としてフォームに代入してくれる

### 登録や編集処理に失敗した時に、フォームの入力値が保持される理由

```ruby
def create
  @user = User.new(user_params)
  if @user.save...①
    redirect_to root_path
  eles
    render :new...②
  end
end
```

1：createアクションで@userを作って保存しようとするが失敗する。（保存に失敗しても@userにはparamsから受け取った値が入ってる）

2：else句でrender :newが実行され、再度new.html.erbがレンダリングされる。

  この時、入力フォームの値が入った@userがnew.html.erbに渡される。

3：`form_with(model: @user)`の記述により、@userに入っている値が入力フォームに代入された状態でページが表示される。

  modelオプションでインスタンス変数を指定していなければ、入力した情報はどこにも保持されないので、入力フォームには反映されない。

### 参考文献

- 全体

[https://qiita.com/RIN_HM/items/464827b6055aa9748425](https://qiita.com/RIN_HM/items/464827b6055aa9748425)

[https://qiita.com/yamaday0u/items/a3689bc48a7eff55929b](https://qiita.com/yamaday0u/items/a3689bc48a7eff55929b)

- local: true

[https://qiita.com/kakudaisuke/items/e032c7705db00e8081dc](https://qiita.com/kakudaisuke/items/e032c7705db00e8081dc)
