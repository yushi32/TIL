## Active Storageとは
### 概要
Amazon S3、Google Cloud Storageなどの外部のクラウドストレージサービスへのファイルのアップロードや、ファイルをActive Recordオブジェクトにアタッチする機能を提供する。<br/>
Active Storageの多くの機能は、Railsによってインストールされないサードパーティソフトウェアに依存しているため、別途インストールが必要。

- [libvips](https://github.com/libvips/libvips) v8.6以降（または[ImageMagick](https://imagemagick.org/index.php)）: 画像解析や画像変形用
- [ffmpeg](http://ffmpeg.org/) v3.4以降: 動画プレビュー、ffprobeによる動画/音声解析
- [poppler](https://poppler.freedesktop.org/)または[muPDF](https://mupdf.com/): PDFプレビュー用

また、画像分析や画像加工のために`image_processing` gemも必要になる。

### 仕組み
Active Storageは、アプリケーションのデータベースで`active_storage_blobs`、`active_storage_attachments`、`active_storage_variant_records`という3つのテーブルを使用する。<br/>
それぞれのテーブルの役割は以下のようになっている。<br/>
どのモデルで保存された画像も`active_storage_blobs`と`active_storage_attachments`の2つのテーブルを使うことになるため、ポリモーフィック関連を選択・利用していることになる。
- `active_storage_blobs`

実際のファイルのデータを保存する。<br/>
ファイルのバイナリデータやメタデータ（ファイル名、MIMEタイプ、サイズなど）が格納される。

- `active_storage_attachments`

どのモデルがどのファイルをアタッチしているかという、ファイルのアタッチメント情報（通常はモデル名とID）を保持する。<br/>
`active_storage_blobs`テーブル内のデータとモデルのレコードを紐づける役割を果たす。

- `active_storage_variant_records`

Active Storageが画像の変換済みバリアント（サムネイルなどのリサイズやフィルタ処理を適用したバージョン）を管理する。<br/>
これにより、必要なサイズやフォーマットに変換された画像を効率的に提供できるようになる。<br/>

### セットアップ
1. 3つのテーブルを作成するマイグレーションファイルを生成:
```ruby
$ rails active_storage:install
```
2. マイグレーションを実行:
```ruby
$ rails db:migrate
```
3. Active Storageで使うサービスを`config/storage.yml`で宣言する

### モデルにアタッチする
ファイルの情報は`active_storage_blobs`テーブルが保持しているので、どちらの場合でもモデルに新しくカラムを追加する必要がないというのがポイント。
- `has_one_attached`
  
レコードとファイルの間に1対1のマッピングを設定する。
```ruby
class User < ApplicationRecord
  has_one_attached :avatar
end
```

- `has_many_attached`

レコードとファイルの間に1対多の関係を設定する。
```ruby
class Board < ApplicationRecord
  has_many_attached :images
end
```
`has_many_attached`は複数の画像が添付される可能性があるので、ストロングパラメータに属性を追加する時は、配列として定義する。<br/>
データ型は`ActiveStorage::Attached::Many`になる。
```ruby
class BoardsController < ApplicationController
  ...
  def board_params
    params.require(:board).permit(:title, :body, images: [])
  end
end
```
- 添付した画像を表示する
```ruby
<%= image_tag @user.avatar %>

<% @board.images.each do |image| %>
  <%= image_tag image %>
<% end %>
```

### その他
- `service`オプション

デフォルトのサービスを上書きする。
```ruby
class User < ApplicationRecord
  has_one_attached :avatar, service: :s3
end
```

- `attach`メソッド

既存のインスタンスにファイルを添付する場合は、`attach`メソッドを使う。
```ruby
user.avatar.attach(params[:avatar])
board.images.attach(params[:images])
```

- `attached?`メソッド
  
特定のインスタンスにファイルが添付されてるかを調べる時は、`attached?`メソッドを使う。
```ruby
user.avatar.attached?   #=> ファイルが添付されていなければ、falseが返る
board.images.attached?  #=> 1件でもファイルが添付されていれば、trueが返る
```

- `purge`メソッド

添付した画像を削除したい時は、`purge`メソッドを使う。
```ruby
user.avatar.purge
board.images.purge
```

### 参考文献
- [Railsガイド Active Storageの概要](https://railsguides.jp/active_storage_overview.html)
- [Pikawaka 【Rails】 Active Storageを使って画像をアップしよう！](https://pikawaka.com/rails/active_storage)
- [今更ながらActiveStorageの仕組みとか使い方とかメモ📝
](https://madogiwa0124.hatenablog.com/entry/2021/11/20/175116#:~:text=ActiveStorage%E3%81%A8%E3%81%AF&text=Rails%205.2%E3%81%A7%E5%B0%8E%E5%85%A5%E3%81%95%E3%82%8C,%E3%81%BB%E3%81%86%E3%81%8C%E8%89%AF%E3%81%84%E3%81%8D%E3%81%8C%E3%81%97%E3%81%9F%E3%80%82)
- [【Rails6.0】Active Storageを用いた単数枚、複数枚画像投稿の実装手順をそれぞれ解説](https://techtechmedia.com/active-storage-rails6/)
- [[Rails]Active Storageを理解してない人は覗いてご覧なさい](https://qiita.com/ren0826jam/items/58bdbaff17581280ee5a)
