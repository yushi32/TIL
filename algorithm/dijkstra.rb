h, w = gets.split(' ').map(&:to_i)
grid = h.times.map { gets.split(' ').map(&:to_i) }

sx = 0
sy = 0
gx = w - 1
gy = h - 1

dx = [1, 0, -1, 0]
dy = [0, 1, 0, -1]

dist = Array.new(h) { Array.new(w, Float::INFINITY) }
dist[sy][sx] = 0

queue = [[sx, sy, 0]]

# 優先度付きキューを表現するために、キューの順序がコスト順になるようにする
# bsearch_indexメソッドを使用することで、効率の良い二分探索で挿入位置を見つけられる
def insert_node(queue, node)
  index = queue.bsearch_index { |n| n[2] > node[2] } || queue.length
  queue.insert(index, node)
end

while !queue.empty?
    x, y, d = queue.shift
    # d: キューに追加した時点での最短距離
    # 後の処理でもう一度同じ頂点への最短距離が計算され更新されている可能性がある
    next if d > dist[y][x]
    
    4.times do |i|
        nx = x + dx[i]
        ny = y + dy[i]
        
        if nx >= 0 && nx < w && ny >= 0 && ny < h && d + grid[ny][nx] < dist[ny][nx]
            dist[ny][nx] = d + grid[ny][nx]
            insert_node(queue, [nx, ny, dist[ny][nx]])
        end
    end
end

puts dist[gy][gx]
