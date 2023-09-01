## ポリモーフィック関連付けとは
ある1つのモデルが他の複数のモデルに属していることを、1つの関連付けだけで表現できる関連付けのこと。<br/>
これにより、1つのテーブルで複数の異なるモデルを参照できるようになる。<br/>
ポリモーフィックな`belongs_to`は、他のあらゆるモデルから利用可能なインターフェイスを設定する宣言とも言える。<br/>

※ ポリモーフィック（polymorphic）<br/>
多形の, 多様な形をもつ; 《オブジェクト指向プログラミングで》 多相型の, 多相的な, 多相性のある（研究社 英和コンピューター用語辞典）<br/>


### ダックタイピング／インターフェースとは
- ダックタイピング
  
「違うものがある決まった振る舞い／入出力を持つことで、同じように扱えるようにすること」をダックタイピングと呼ぶ。

- インターフェース
  
ダックタイピングにおける「ある決まった振る舞い」「入出力の定義」のことをインターフェースと呼ぶ。

サンプルコード:
```ruby
class Animal
  def bark
    puts self.sound
  end
end

class Duck < Animal
  def sound
    'クワックワッ'
  end
end

class Cat < Animal
  def sound
    'ニャー'
  end
end

taro = Duck.new
jiro = Cat.new

taro.bark #=> クワックワッ
jiro.bark #=> ニャー
```
サンプルコードであれば、`Duck`と`Cat`は違うクラスではあるけれど、両方とも`sound`メソッド（**インターフェース**）を持つので、`Animal`の中ではどちらのオブジェクトであるかを意識せず`sound`メソッドを呼ぶことができる、というのが**ダックタイピング**。


### 具体例で考える
PictureモデルがEmployeeモデルとProductモデルに属する場合の関連付けをポリモーフィック関連付けを使わずに定義した場合:
```ruby
class Picture < ApplicationRecord
  belongs_to :employee 
  belongs_to :product
end

class Employee < ApplicationRecord
  has_many :pictures
end

class Employee < ApplicationRecord
  has_many :pictures
end
```
上記のように、Pictureモデルに関連付けの数だけ`belongs_to`を記述しなければいけない。<br/>
また、Picturesテーブルに`employee_id`カラムと`product_id`カラムといった外部キーが必要になる。


これをポリモーフィック関連付けを利用して書き換えると以下のようになる:
```ruby
class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true
end

class Employee < ApplicationRecord
  has_many :pictures, as: :imageable
end

class Product < ApplicationRecord
  has_many :pictures, as: :imageable
end
```
この場合、`imageable_id`カラムに外部キーを保持して、`imageable_type`カラムにEmployeeモデルとProductモデルのどちらに属するかの情報を保持する。<br/>
また、`@picture.imageable`とすることで、`@picture`というインスタンスがEmployeeモデルとProductモデルのどちらと関連付けられているかの情報を取得できる。<br/>

つまり、類似した関連付けが存在する場合に、個別に関連付けを定義するのではなく、疑似的な関連付けのインターフェースを定義して、それを介することで複数の関連付けを1つにまとめるための機能。
```ruby
# イメージとしてはこんな感じ

# 個別に関連付けを定義した場合
Picture < Employee
Picture < Product

# ポリモーフィック関連付けを利用した場合
Picture < imageable < Employee, Product
```
### マイグレーション
ポリモーフィックなインターフェイスを宣言するモデルで、外部キーのカラムと型のカラムを両方とも宣言しておく必要がある。
```ruby
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string  :name
      t.bigint  :imageable_id
      t.string  :imageable_type
      t.timestamps
    end

    add_index :pictures, [:imageable_type, :imageable_id]
  end
end
```
`t.references`という書式を使うと、よりシンプルに記述できる。
```ruby
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string  :name
      t.references :imageable, polymorphic: true
      t.timestamps
    end
  end
end
```

### 中間テーブルとして扱う
以下の場合を考える:
- `User`モデルは`Event`モデルと関連を持つ
- `User`は`Event`を中間テーブルとして、`Concert`と`Match`と関連を持つ
- `Event`と`Concert`・`Match`は、ポリモーフィック関連が定義されている
```ruby
class User < ApplicationRecord
  has_many :events
  has_many :concerts, through: :events, source: :eventable, source_type: :'Concert'
  has_many :matches, through: :events, source: :eventable, source_type: :'Match'
end

class Event < ApplicationRecord
  belongs_to :eventable, polymorphic: true
end

class Concert < ApplicationRecord
  has_many :events, as: :ticketable
  has_many :users, through: :event
end

class Match < ApplicationRecord
  has_many :events, as: :ticketable
  has_many :users, through: :event
end
```
- `through`で中間テーブルのモデルを指定 
- `source`で中間テーブルの先の関連モデルを指定（関連付けの情報は、Eventsテーブルの`eventable_id`カラムと`evantable_type`カラムに保持されているため）
- `source_type`でポリモーフィック関連のソースのタイプを指定（`eventable_type`カラムにどのモデルを指定するか）



### ポリモーフィック関連付けを使う時の注意点
- ポリモーフィック関連付けを定義した場合、外部キー制約を使用することができない
  
※ 外部キー制約とは...親テーブルに存在しないデータを子テーブルが持つことが無いようにするための制約のこと。

- ポリモーフィック関連したデータに対しては、`joins`や`eager_load`メソッドは データを取得・参照できない
  
`joins`や`eager_load`メソッドでは、テーブルの結合条件を事前に指定しないといけないため。<br/>
ポリモーフィック関連では、関連するテーブルが動的、かつ、実行時にどのテーブルと結合するかが決まる（レコードによって結合先のテーブルが異なる）。

- ポリモーフィック関連したデータを取得するときは、`includes`と`preload`メソッドを使用する
  
`includes`と`preload`メソッドは、関連するデータを取得する際にデータベースの結合（JOIN）を使わずに、クエリを発行することで関連データを取得するため。

### 参考文献
- [Railsガイド Active Recordの関連付け ポリモーフィック関連付け](https://railsguides.jp/association_basics.html#%E3%83%9D%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%95%E3%82%A3%E3%83%83%E3%82%AF%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91)
- [Railsのポリモーフィック関連とはなんなのか](https://qiita.com/itkrt2y/items/32ad1512fce1bf90c20b)
- [SQLアンチパターン　ポリモーフィック関連について](https://zenn.dev/kingdom0927/articles/b2097fadaf7543)
- [Railsのポリモーフィック関連付けを理解する](https://qiita.com/sazumy/items/726e7097c6ca4a9ca6e3)

**関連**
- [プログラマー１年生がポリモーフィズムについて学んだのでＲＰＧで説明する。](https://qiita.com/Nossa/items/b6e2f4ed0fa079359fc5)
- [外部キーとは？〜概要から変数や処理の書き方を解説〜](https://products.sint.co.jp/siob/blog/what-is-foreign-key)
