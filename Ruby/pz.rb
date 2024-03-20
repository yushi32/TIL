# 一行の入力を受け取る => gets
input_line = gets

# 末尾の改行コードを削除する => chomp
input_line = gets.chomp

# 文字列を配列に分割する => split
# 引数に区切り文字を渡す
array = str.split(' ')

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


# 配列に対して同じ処理を繰り返す => map
array.map { |arr| puts arr } 
# 繰り返し処理がメソッド呼び出しの場合、簡略化して記述できる
array.map(&:to_i)

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
