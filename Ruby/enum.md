## Rubyの列挙型(enum)とは

Rubyの列挙型(enum)は、特定の値の集合を定義するためのデータ型。  
列挙型を使用することで、固定された選択肢や状態を表現しやすくなる。

列挙型は、事前に定義された一連の値の中から一つを選択するために使用される。  
各値には名前が付けられ、その名前を使って値を参照することができる。

Rubyの列挙型は、Enumモジュールを使用して定義される。  
Enumモジュールをincludeすることで、列挙型を定義することができる。

### 定義と使用例
```ruby
# app/models/user.rb
class User < ApplicationRecord
  enum status: { active: 0, inactive: 1, pending: 2 }
end
```
上記の例では、Userモデル内でstatusという列挙型を定義している。  
status列挙型には、active、inactive、pendingの3つの値を定義されている。  
各値には数値が関連付けられており、activeは0、inactiveは1、pendingは2に対応している。　　

この列挙型を使用することで、Userモデルのインスタンスに対して、簡単に状態を表現できる。  
例えば、以下のようにして状態を取得したり設定したりすることができる。

```ruby
user = User.new(status: :active)
user.active?  #=> true
user.status   #=> "active"

user.inactive!
user.active?  #=> false
user.inactive?  #=> true
user.status   #=> "inactive"
```
また、列挙型を使用すると、データベースのカラムに対しても整数型で保存される。  
このため、データベース内での値の比較や検索も容易になるというメリットがある。
