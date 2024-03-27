h, w = gets.split(' ').map(&:to_i)
maze = h.times.map { gets.split(' ').map(&:to_i) }

start_x = 0
start_y = 0
goal_x = w - 1
goal_y = h - 1

direction_x = [1, 0, -1, 0]
direction_y = [0, 1, 0, -1]

distance = Array.new(h) { Array.new(w) }
distance[start_y][start_x] = 1

queue = [[start_x, start_y]]

while !queue.empty?
  x, y = queue.shift
  break if x == goal_x && y == goal_y

  4.times do |i|
    next_x = x + direction_x[i]
    next_y = y + direction_y[i]

    if next_x >= 0 && next_x < w && next_y >= 0 && next_y < h && distance[next_y][next_x].nil?
      next if maze[next_y][next_x] == 1
      
      queue.push([next_x, next_y])
      distance[next_y][next_x] = distance[y][x] + 1
    end
  end
end

puts distance[goal_y][goal_x]
