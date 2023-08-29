## Form Objectとは
`form_with`メソッドの`model`オプションに`Active Record`以外のオブジェクトを渡すデザインパターンのこと。<br/>
フォームから送信された値をDBに保存しない場合や、フォームとモデルが1対1で紐づかない時に便利。<br/>
また、このクラスから作ったインスタンスのこともフォームオブジェクトと呼ぶ。

### Form Objectの利点
- DBを使わないフォームでも、Active Recordを利用した場合と同じお作法を利用できるので可読性が増す
- 他の箇所に分散されがちなロジックをForm Object内に集めることができ、凝集度を高められる

Form Objectを使わない場合、Controller内に多くのロジックが入り込んでコードが読みづらくなる。<br/>
Controllerでparamsを使って大量のロジックを書いている場合、Form Objectを使えないか検討すべし。

### Form Objectの作り方
`ActiveModel::Model`を`include`したクラスを作成すればOK。<br/>
`ActiveModel::Attributes`も`include`しておくと、属性に型を指定した変換したりできるようになる。
```ruby
class search_posts_form
  include ActiveModel::Model
  include ActiveModel::Attribute

  attribute :author, :string
  attribute :title, :string
  attribute :body, :string
end
```

### ActiveModel::Modelモジュール
`ActiveModel::Model`モジュールを`include`すると、`ActiveModel::API`のすべての機能を利用できるようになる。
- モデル名のイントロスペクション: 単数系と複数形の予測
- 変換: Railsのモデルの変換メソッド(`to_model`, `to_key`, `to_param`, `to_partial_path`)が利用できるようになる
- 翻訳（i18n）
- バリデーション
- `form_with`メソッドや`render`メソッドなどのAction Viewヘルパー

### ActiveModel::Attributesモジュール
モデルや`ActiveModel::Model`モジュールを継承しているクラスで、型付きの属性を定義したり、型変換の機能を提供する。


### 参考文献
- [Railsガイド ActiveModelの基礎](https://railsguides.jp/active_model_basics.html#model%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB)
- [form objectを使ってみよう](https://tech.medpeer.co.jp/entry/2017/05/09/070758)
- [ActiveModel::ModelモジュールとActiveModel::Attributesモジュール](https://higmonta.hatenablog.com/entry/2021/11/26/030259)
- [Railsのデザインパターン: Formオブジェクト](https://applis.io/posts/rails-design-pattern-form-objects)
- [詳解Railsデザインパターン：Formオブジェクト](https://takaokouji.github.io/output/form-object/)
