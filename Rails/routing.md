# ルーティング

### 概要

- アプリケーションに対して送られたリクエストを、どのControllerのどのActionで処理するかを決める分配表のこと
- RailsのルーターはパスやURLも生成してくれるので、ビューの
- ルーティングは、`config/routes.rb`ファイルの上から順にマッチするか検索していくので、書く順番に注意すべき時がある

### リソースベースルーティング

- RESTというアプリケーションの設計方法に基づいて設定されている
- 操作の対象となるリソースをURLを使って表し、それに対してHTTPメソッドを使って操作を行うというもの
- 例えば、`https://localhost:3000/sample`というURLに、HTTPのGETメソッドでアクセスすればデータを取得し、PUTでアクセスすればデータの更新が行われる、というような方式
- Railsアプリケーションの場合、対象となるリソースはDBに格納されたデータのこと
- リソースフルルーティングでは基本の7つのアクションに対して、HTTPメソッドとパスが割り当てられていて、それらを一括で定義することが出来る

### リソースフルルーティング

特徴

- コントローラごとに既定の7つのアクション（CRUD操作）に対するルーティングを自動で生成してくれる
- 生成したルーティングに対するURLヘルパーも生成してくれる
- URLヘルパーの引数に`:id`の代わりにオブジェクトを渡すことで、オブジェクトから`:id`を抽出してくれる

種類

- resourcesメソッド

idによる差分が必要なテーブルを扱う場合に用いる

定義する時は、複数形 ⇒ `resources :posts`

以下の7つのルーティングを定義する：

| HTTPメソッド | パス | コントローラ#アクション | pathヘルパー（Prefix） |
| --- | --- | --- | --- |
| GET | /posts | posts#index | posts_path |
| GET | /posts/new | posts#new | new_posts_path |
| POST | /posts | posts#create | posts_path |
| GET | /posts/:id | posts#show | post_path(:id) |
| GET | /posts/:id/dit | posts#edit | edit_post_path(:id) |
| PATCH/PUT | /posts/:id | posts#update | post_path(:id) |
| DELETE | /posts/:id | posts#destroy | post_path(:id) |

*`:id`を指定する必要がある時は単数系のパスになると考えると分かりやすい

*`:id`を数字で渡す代わりにインスタンスを引数として渡せる

- resource

idによる差分が必要ない場合はこちら

定義する時は、単数系 ⇒ `resource :profile`

以下の6つのルーティングを定義：

| HTTPメソッド | パス | コントローラ#アクション | pathヘルパー |
| --- | --- | --- | --- |
| GET | /profile/new | profile#new | new_profile_path |
| POST | /profile | profile#create | profile_path |
| GET | /profile | profile#show | profile_pat |
| GET | /profile/edit | profile#edit | edit_profile_path |
| PATCH/PUT | /profile | profile#update | profile_path |
| DELETE | /profile | profile#destroy | profile_path |

### ヘルパーメソッド

- リソースフルルーティングを定義すると、コントローラやビューで多くのヘルパーが使えるようになる
- pathヘルパーは上記の表を参照
- urlヘルパーは、「http」から始まる完全なURLの文字列を返す

### その他あれこれ

- root_pathと任意のパス指定
    - rootは、そのドメインのトップページのURLのこと
    - パスに対して、任意のアクションをルーティング出来る

```ruby
# localhost:3000にアクセスすると、掲示板一覧ページが表示される
root 'boards#index'

# /loginにアクセスすると、user_sessions#newがリクエストを処理する
get 'login', :to 'user_sessions#new'
```

- ネストしたリソース
    - 親子関係にあるリソースをルーティングで表したい時に用いる
    - 例えば、掲示板についたコメントなど
    - 以下のように定義する：
    
    ```ruby
    resources :boards do
    	resources :comments
    end
    ```
    
    - パスは以下のようになる：
    
    | コントローラ#アクション | pathヘルパー | パス |
    | --- | --- | --- |
    | comments#index | /boards/:board_id/comments | board_comments_path(@board) |
    | comments#new | /boards/:board_id/comments/new | new_board_comments_path(@board) |
    | comments#create | /boards/:board_id/comments | board_comments_path(@board) |
    | comments#show | /boards/:board_id/comments/:id | board_comment_path(@board, @comment) |
    | comments#edit | /boards/:board_id/comments/:id/edit | edit_board_comment_path(@board, @comment) |
    | comments#update | /boards/:board_id/comments/:id | board_comment_path(@board, @comment) |
    | comments#destroy | /boards/:board_id/comments/:id | board_comment_path(@board, @comment) |
    
    *resources単体の時と同じく、id指定が必要な時は単数系になる
    
    *`url_for`を使うと、複数のオブジェクトを渡しても適切なルーティングを自動で検索してくれる
    
    ```ruby
    <%= link_to 'コメント編集', edit_board_comment_path(@board, @comment) %>
    <%= link_to 'コメント編集', url_for(@board, @comment) %>
    ```
    

- 浅いネスト

idを持たないアクション（index, new, create）だけを親のスコープの下に生成する

親のリソースで`shallow: true`オプションを指定すると、すべてのネストしたリソースが浅くなる

定義：

```ruby
resources :boards do
	resouces :comments, shallow: true
end

# 上を書き換えると
resources :boards do
	resouces :comments, only: %i[index new create]
end
resouces :comments, only: %i[show edit update destroy]
```

- namespace
    - コントローラを名前空間でグループ化したい時に用いる
    - 例えば、`Admin::`名前空間でまとめたコントローラは、`app/controllers/admin`ディレクトリに配置する
    - ルーティングは、`/admin/users`のようになる

- RESTfulなアクションをさらに追加する

基本の7つのアクション以外のアクションとパスをルーティングに追加する

追加したアクションのヘルパーは、`追加したアクション_path/url`の形式になる

member：id付きのルーティングを生成

```ruby
resources :boards do
	get 'preview', on: :member
end
```

collection：idのないルーティングを生成

```ruby
resources :boards do
	get 'bookmarks', on: :collection
end
```

- 名前付きルーティング

`:as`オプションを使うと、指定したルーティングに任意のpathヘルパーとurlヘルパーを生成できる

```ruby
# logout_pathとlogout_urlのヘルパーメソッドが生成される
# パスは/exit
get 'exit', to: 'sessions#destroy', as: :logout
```

### 参考文献

- Railsガイド、だいたい全部書いてある

[https://railsguides.jp/routing.html](https://railsguides.jp/routing.html)

- pathヘルパーとurlヘルパー

[https://qiita.com/higeaaa/items/df8feaa5b6f12e13fb6f](https://qiita.com/higeaaa/items/df8feaa5b6f12e13fb6f)
