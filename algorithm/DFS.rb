h, w = gets.split(' ').map(&:to_i)
city = h.times.map { gets.chars }

sx = 0
sy = 0
gx = 0
gy = 0
city.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    if cell == 's'
      sx = j
      sy = i
    elsif cell == 'g'
      gx = j
      gy = i
    end
  end
end

dx = [1, 0, -1, 0]
dy = [0, 1, 0, -1]

stack = [[sx, sy]]

while !stack.empty?
  x, y = stack.pop
  break if x == gx && y == gy
  
  4.times do |i|
    nx = x + dx[i]
    ny = y + dy[i]
    
    if nx >= 0 && nx < w && ny >= 0 && ny < h && city[ny][nx] != '#'
      stack.push([nx, ny])
      city[ny][nx] = '#'
    end
  end
end

puts city[gy][gx] == '#' ? 'Yes' : 'No'
