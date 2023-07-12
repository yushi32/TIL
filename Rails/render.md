# renderメソッド

### 概要

- 渡された引数を元に、HTTPレスポンスを作成する
    - レスポンスだけを作成するので、リクエストを処理する流れとは異なる
- 簡単に言えば、ビューファイルのファイルパスを渡されればそれを元にHTMLを生成してレスポンスとして返す
- renderメソッドに渡せるのは、ビューファイル・オブジェクト・文字列の3つ
- コントローラとビューで使える

### コントローラから呼び出すrender

- 明示的に使うのは、オブジェクトの生成に失敗した時

```ruby
def create
  @user = User.new(user.params)
  if @user.save
    redirect_to posts_path
  else
    render :new
  end
end
```

- 明示的に記述しない場合でも、暗黙にrenderメソッドが呼ばれている

```ruby
def new
  @user = User.new
  #　ここでビューファイルを呼び出してるから、
  # 生成したインスタンス変数がビューファイルに渡されてレンダリング出来る
end
```

- renderメソッドの省略あれこれ

まず、大前提として、`app/views`ディレクトリ内にあるファイルが探索対象

1. コントローラ名とアクション名が一致していれば、省略可能
    - users#newでrenderメソッドが省略された場合、`views/users/new.html.erb`が呼び出される
2. 同じコントローラ内なら、コントローラ名は省略可能
    
    ```ruby
    def edit
      @user = User.new(params_user)
      if @user.save
        ...
      else
        render 'users/new'
      end
    end

    # 上記の例なら：
      render 'new'
    # と書いてもOK
    ```
    
3. フォルダ名がない時は、シンボルで指定可能
    
    ```ruby
    # 下記の2つは同じ
    render 'new'
    render :new
    ```
    

### ビューから呼び出すrender

基本的には、テンプレートの中でパーシャル（部分テンプレート）を呼び出すために使われる。

```ruby
# 何も省略しないで書くとこう：
<%= render(partial: 'パーシャルのファイルパス', locals: { board: @board }) %>

# オプションは省略して簡潔に書ける
<%= render 'パーシャルのファイルパス', board: @board %>
```

### renderメソッドのオプションあれこれ

- collectionオプション

コレクション（レコードを格納した配列）をパーシャルに渡して、繰り返しレンダリングする時に使う。

collectionオプションを指定する時は、パーシャルの指定を省略して書くことは出来ない。

`render @boards`と書いた時は、指定したコレクションのモデル名を元に呼び出すパーシャルを決定する。

⇒ 今回だと、@boardsに格納されているオブジェクトはBoardモデルのインスタンスなので、`_board.html.erb`が呼び出される。

```ruby
# collectionオプションを使わない場合
<% @boards.each do |board| %>
  <%= render 'board', board: board %>
<% end %>

# collectionオプションを使って書き直す
<%= render partial: 'board', collection: @boards %>

# さらに省略してかける
<%= render @boards %>
```

- objectオプション

パーシャルに単一のオブジェクトを渡すためのオプション。

パーシャル内からは、`object`というローカル変数を使ってアクセスする。

エラーメッセージなどの汎用的なパーシャルの場合、ローカル変数をobjectで固定出来る。

というか、localsオプションの変数名をobjectにしてるだけだな。

```ruby
<%= render 'shared/errer_messages', object: @board.errors >
```

### 参考文献

- renderメソッドの引数のルール（主にコントローラ）

[https://ichigick.com/rails-render-arguments-rule/](https://ichigick.com/rails-render-arguments-rule/)
