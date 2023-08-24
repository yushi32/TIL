## 演算子まとめ
初めて見た演算子や使い方がよく分からない演算子についてのまとめ。

### ぼっち演算子

Ruby2.3から実装された機能。正式には **safe navigation operator** と呼ぶ。<br/>
レシーバが`nil`である可能性がある場合や、レシーバのクラスに定義されていないメソッドを使おうとした場合、そのままメソッドを使うと`NoMethodError`が発生してしまう。<br/>
ぼっち演算子を使うと、エラーを発生させずに`nil`を返してくれる。
```ruby
# ログイン中のユーザーがいない場合、current_userの中身はnilになるのでエラーが発生する
@user_name = current_user.name

# ぼっち演算子を使うことでエラーを回避できる
@user_name = current_user&.name

# ぼっち演算子を使わない場合分けが必要になる
@user_name = ''
if current_user
  @user_name = current_user.name
end
```

**参考文献**

Ruby ぼっち演算子について: https://qiita.com/yoshi_4/items/e987b698c1978d248cfc

### 三項演算子

if文を簡潔に記述できる演算子。
- 書式
```ruby
# 三項演算子
条件式 ? trueの処理 : falseの処理

# ifを使って書くと：
if 条件式
  trueの処理
else
  falseの処理
end
```
- 具体例
```ruby
a = 3

# if文
if a % 3 == 0
  puts '3の倍数です'
else
  puts '3の倍数ではありません。
end

# 三項演算子
puts a % 3 == 0 ?　'3の倍数です' : '3の倍数ではありません'
```

### 自己代入演算子

`演算子(op) + =`の形になっているもの。<br/>
以下の演算子が使える。
```ruby
+, -, *, /, %, **, &, |, ^, <<, >>, &&, ||
```

基本的に、`左辺 op= 右辺`は、`左辺 = 左辺 op 右辺`のように評価される。<br/>
`&&`と`||`の場合のみ、`左辺 op (左辺 = 右辺)`と評価される。
```ruby
# 例えば
a += 1 # は、
a = a + 1 # と評価される

a ||= 1 # は、
a || (a = 1) # と評価される
```

- `||=`は、どういう場合に使われるのか？

変数を初期化する時によく使われるイディオム。（恐らく`nil`を避けるため）<br/>
既に値が代入されていればその値を返し、`false`もしくは`nil`の場合は右辺を代入する。<br/>
```ruby
@user ||= user.find(id: params[:id])
```

**参考文献**<br/>
Rubyリファレンスマニュアル: https://docs.ruby-lang.org/ja/latest/doc/spec=2foperator.html#selfassign
