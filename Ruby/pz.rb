# 一行の入力を受け取る => gets
input_line = gets

# 末尾の改行コードを削除する => chomp
input_line = gets.chomp

# 文字列を配列に分割する => split
# 引数に区切り文字を渡す
array = str.split(' ')
# 連続する文字列を1文字ずつ配列に入れる
array = str.chars

# 文字列同士を結合する => <<, concat
# レシーバを破壊的に変更する、+演算子は毎回新しくオブジェクトを作るため、効率が悪い
str = 'abc'
str << 'def' #=> 'abcdef'
str.concat('def') #=> 'abcdef'

# 配列を結合して文字列を生成する
array = ['a', 'b', 'c']
array.join #=> '123'
array.join(' ') #=> '1 2 3'

# 文字列の切り取り => slice, slice!
# 指定した箇所または範囲の文字列を切り取った新しい文字列を作成する
# slice!メソッドを使うと、元の文字列から切り取った文字列が削除される（破壊的メソッド）
str = 'world'
str.slice(3) #=> 'l'
str.slice(0, 2) #=> 'wor'
str.slice(0..2) #=> 'wor'
str #=> 'world'

str.slice!(0..2) #=> 'wor'
str #=> 'ld'

# 一致した文字列をすべて置き換える => gsub, gsub!
str = 'hello, world!'
puts str.gsub('l', 'x') #=> 'hexxo, worxd!'


# 数値の大小を比較する
a = 3
b = 7
[a, b].max #=> 7
[a, b].min #=> 3
[a, b].minmax #=> [3, 7]

# 絶対値を求める => abs
-123.abs #=> 123
(3 - 7).abs #=> 4

## 特定の数値範囲で繰り返し処理を行う => upto, downto
#  昇順
3.upto(7) do |i|
  puts i #=> 3, 4, 5, 6, 7
end

#  降順
7.downto(3) do |i|
  puts i #=> 7, 6, 5, 4, 3
end

# 文字列、数値を浮動小数点数に変換する => to_f
str.to_f
int.to_f

## 小数に対する操作
float = 12.345
#  四捨五入 => round
float.round #=> 12, 戻り値はInteger
float.round(2) #=> 12.35

#  切り上げ => ceil
float.ceil #=> 13, 戻り値はInteger
float.ceil(2) #=> 12.35

# 切り捨て => floor
float.floor #=> 12, 戻り値はInteger
float.floor(2) #=> 12.34


# 配列の初期化
Array.new(3, 0) #=> [0, 0, 0]
# 二次元配列の初期化
Array.new(2) { Array.new(3, 0) } #=> [[0, 0, 0], [0, 0, 0]]

# xからyまでの数値の配列を作成する => to_a
array = (1..5).to_a #=> [1, 2, 3, 4, 5]

# 配列から重複ありで隣り合う要素をn個ずつ取り出す => each_cons
array = [2, 3, 6, 4, 1, 5]
array.each_cons(3) do |a, b, c|
  puts a + b + c #=> 11, 13, 11, 10
end

# 配列に対して同じ処理を繰り返した結果を新しい配列として返す => map
new_array = array.map { |arr| puts arr * 2 } 
# 繰り返し処理がメソッド呼び出しの場合、簡略化して記述できる
new_array = array.map(&:to_i)

# 配列から条件に一致する要素だけからなる新しい配列を返す => select
# select!メソッドは、レシーバの配列そのものを変更する
array = [1, 2, 3, 4, 5, 6]
new_array = array.select { |arr| arr.odd? } # 奇数だけの新しい配列を返す
array.select! { |arr| arr.odd? } # 元の配列から偶数の要素だけを削除する

# 配列から条件に一致する要素を削除した新しい配列を返す => reject
# reject!メソッドは、レシーバの配列そのものを変更する
new_array = array.reject { |arr| arr.even? } # 奇数だけの新しい配列を返す
array.reject! { |arr| arr.even? } # 元の配列から偶数の要素だけを削除する

## 配列操作に関するメソッド
#  以下のメソッドはレシーバの配列そのものを変更する（破壊的メソッド）
#  配列の先頭に要素を追加する => unshift
array.unshift
#  配列の末尾に要素を追加する => push
array.push
#  配列の先頭の要素を削除する => shift
array.shift
# 　配列の末尾の要素を削除する => pop
array.pop
# 指定した位置に要素を挿入する => insert
array = [1, 3, 7, 9]
array.insert(2, 5)
p array #=> [1, 3, 5, 7, 9]

# 指定した要素のインデックス番号を取得する => index, rindex
array = [3, 1, 4, 2, 1, 5]
# 最初に現れる位置
array.index（1） #=> 1
# 最後に現れる位置
array.rindex(1) #=> 4

# ブロックの条件式に対して初めてtrueを返した要素の位置を返す => bsearch
# レシーバの配列はあらかじめソートされている必要がある、二分探索で検索するので効率が良い、trueを返す要素がなければnilを返す
array = [1, 3, 5, 7, 13, 16]
array.bsearch { |n| n >= 9 } #=> 4
array.bsearch { |n| n >= 20 } #=> nil

# 二次元配列を一次元配列にした新しい配列を返す => flatten
array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
new_array = array.flatten

# 配列に含まれる要素を数え上げた結果をハッシュで返す => tally
array = ['a', 'b', 'c', 'b']
hash = array.tally #=> {"a"=>1, "b"=>2, "c"=>1}

# ハッシュの初期化
new_hash = Hash.new { |hash, key| hash[key] = '初期値' }
# ブロックを渡すことで、指定したキーがなかった時に初期値を設定することが出来る
# ブロック変数hashはnew_hash自体を指している
# 例えばnew_hash[5]を参照して存在しなかった場合、「keyが5でvalueが'初期値'」の要素が作成される

# ハッシュをイテレートする時のブロック変数
hash = { dog: 5, cat: 2, fox: 3 }
# キーと値を受け取るために2つの変数が必要
hash.each do |key, value|
  puts "#{key}: #{value}匹" #=> dog: 5匹
end
# ブロック変数が1つだった場合、これを配列としてキーと値が代入される
hash.each do |h|
  p h #=> [:dog, 5]
end

## 配列・ハッシュをレシーバとして、ブロックで評価した結果が最大の時の元の要素、または、引数として指定した数だけ降順に配列に入れて返す => max_by
## ブロックを渡さず、元の要素をそのまま評価する時はmaxメソッドを使う

# 配列の時
array = [-1, 2, 3, -4, 5]
array.max_by { |n| n * (-2) } #=> -4
# 引数に渡した数だけ降順に配列に入れる
array.max_by(3) { |n| n * (-2) } #=> [-4, -1, 2]

# ハッシュの時、最大値を持つキーと値を見つけるシンプルな方法
hash = { dog: 5, cat: 2, fox: 3 }
hash.max_by { |animal, number| number } #=> [:dog, 2]
hash.max_by(2) { |animal, number| number } #=> [[:dog, 2], [:fox, 3]]
