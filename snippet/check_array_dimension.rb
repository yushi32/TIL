# 引数に渡した配列が何次元かを確かめる
def array_dimension(array)
  return 0 unless array.is_a?(Array)

  dimensions = 1
  while array[0].is_a?(Array)
    dimensions += 1
    array = array[0]
  end

  puts "配列は#{dimensions}次元配列です。" 
end
