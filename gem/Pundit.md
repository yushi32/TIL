## gem 'Pundit'とは
gem 'Pundit'は、「認可」の仕組みを提供してくれるライブラリ。<br/>
似たようなgemとして`cancancan`というものがあるが、考え方が異なる。<br/>
- cancancan: ユーザに対して、どんなアクションが許可するかを定義する。コントローラ寄りの責務。
- Pundit: リソースに対して誰が許可されるのかを定義する。モデル寄りの責務。
  
また、Punditが`current_user`メソッドを使うので、`sorcery`などの「認証」の仕組みありきになっている。

### 認可と認証の違い
- **認証 Authentication**
  
通信の相手が誰(何)であるかを確認することが｢認証｣。<br/>
純粋な認証には｢リソース｣やそれに対する｢権限｣という概念はない｡<br/>
つまり、相手が誰なのかを確認するだけで、何らかのアクションやアクセスを許可したりはしない。


- **認可 Authorization**
  
とある特定の条件に対して､リソースアクセスの権限をあたえることが｢認可｣。<br/>
純粋な｢認可｣には､｢誰｣という考え方は存在しない。<br/>
電車の切符のように、乗車の許可が与えられるだけで、誰がその許可を与えられたかという情報は持ち合わせないということ。<br/>
ただ、多くの場合、認証できないと認可できないので、**認可は認証に依存している**と言える。

### インストール
1. Gemfileに以下の記述を追加:
```ruby
gem 'pundit'
```

2. `$ bundle install`を実行
3. ApplicationControllerにincludeする:
```ruby
class ApplicationController < ActionController::Base
  include Pundit
end
```
4. 認可のルールを記述するファイルを作成する:
```ruby
$ rails g pundit:install

# app/policies/application_policy.rb というディレクトリとファイルが生成される
```

- application_policy.rb について
  
このファイルで定義している`ApplicationPolicy`クラスを継承して､他のコントローラごとの認可ルールを記述する｡
```ruby
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end
end
```

`initialize`メソッドの第一引数`user`には、デフォルトで`current_user`メソッドが割り当てられるようになっている｡<br/>
なので、`sorcery`などの認証機能を提供するgemが必要。<br/>

第二引数の`record`は認可をチェックしたいモデルオブジェクトを指す。<br/>
こちらは、対応するモデルのインスタンスを手動で割り当てる。

これを利用することで､**アクセスしているユーザーオブジェクト**と､**対象のリソースオブジェクト**を特定している｡

### 使い方
1. モデルに対応した認可ファイルを作成する。
```ruby
# app/policies/post_policy.rb

class PostPolicy < ApplicationPolicy
  def create?
    # userのアクセス権限がadminかeditorの時のみ認可する
    user.admin? || user.editor?
  end
end
```
- `モデル名_policy.rb`でファイル作成
- `モデル名Policy`でクラス名定義
- `def アクション名?`で認可ルール(policy)を記述

`def アクション名`の戻り値によって、認可するか否かを判断している｡


上記のコードであれば、`def create?`で`false`が返ってくれば､PostControllerのcreateアクションは拒否されて､`Pundit::NotAuthorizedError`という例外が発生する｡

<br/>

2. コントローラ側からPunditを呼び出す

1.で作成したpolicyファイルを適用するために、コントローラからPunditを呼び出す。
```ruby
# app/controller/posts_controller.rb

def create
  authorize(Post)
  ...
end
```
- `authorize`メソッドで､policyファイルに記述された`def create?`が処理される
- 引数にはモデル(リソース)オブジェクトを渡す

### 参考文献
- [Github](https://github.com/varvet/pundit)
- [[Rails]gem Punditによる権限管理 (認可)](https://zenn.dev/yusuke_docha/articles/7b4b2f3f1bb203)
- [Punditをなるべくやさしく解説する](https://qiita.com/yutaro50/items/52484b7ae4ca87aa99a2)
- [Gem Punditの基本的な使い方まとめ](https://otaku-programmer.com/gem/pundit/1/)
