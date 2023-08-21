## gem 'gretel'とは
ユーザーがサイトを利用する際、自分がWebサイト内のどのページにいるかを表現するリストのことを「パンくずリスト」という。<br/>
gretel が提供するメソッドを使うことで、このパンくずリストを簡単に実装することができる。<br/>
童話の「ヘンゼルとグレーテル」が語源になっているらしい。

### インストール
1. Gemfileに以下の記述を追加
   ```ruby
   gem 'gretel'
   ```

3. `$ bundle install`を実行
4. パンくずの設定ファイルを生成する
   ```
   $ rails g gretel:install
   ```
   `config/breadcrumb.rb`が作成されていれば成功。

### 使い方
- `breadcrumb.rb`の初期状態<br/>
  ここにパンくずを追加していく。
  ```ruby
  crumb :root do
    link "Home", root_path
  end
  ```
- パンくずの設定<br/>
  ```ruby
  crumb :ページ名 do
    link 'リンクテキスト', リンクされるURL
    parent :親のページ名（リンク元のページ）
  end


  crumb :items do
    link '商品一覧', items_path
    parent :root
  end

  crumb :item do |item|
    link '商品詳細', item_path(item)
    parent :items
  end
  ```
- 設定したパンくずをビューで表示する
  
  1. `breadcrumb`メソッドを使って、パンくずを呼び出す。

  ```ruby
  <% breadcrumb :items %>
  ```
  
  2. パンくずを表示したい場所に、`breadcrumbs`メソッドを記述する
  
  パンくずリストのHTMLを生成しているのは`breadcrumbs`メソッドであり、`breadcrumb`メソッドはそのページで表示したいパンくずを指定しているため。<br/>
  要するに`breadcrumb`も`breadcrumbs`も両方記述しないとパンくずを表示できないということ。
  
  ```ruby
  # 例えば、パンくずを全てのページに表示するなら、レイアウトファイルに記述する

  <%= breadcrumbs %>
  <%= yield %>
  ```
  
### パンくずを表示する意義
1. ユーザビリティの向上

   パンくずリストを設置することで「自分が今サイト内のどこにいるのか」や「サイトの構造」を認識しやすくなり、結果として使いやすさを高めることができる。

2. 検索エンジンが効率的にクローリングできる
   
   パンくずリストを設置するということは、そのサイトが体系的に整理されることになる。<br/>
   すると、クローラーもパンくずリストによって効率的にそのサイト内のカテゴリーをたどることができるようになるので、サイトの全体像が把握しやすくなり、効率的なクローリングを期待することができる。

   * クローリングとは
     
     インターネット上にあるWebページを巡回して情報を収集すること。<br/>
     クローラーと呼ばれる情報収集ロボットがこれを行なっている。

### 参考文献
Github: https://github.com/kzkn/gretel

Pikawaka: https://pikawaka.com/rails/gretel

【Rails】 Gretelの使い方をざっくりまとめてみた: https://zenn.dev/yukihaga/articles/789d0c6c736335

  
