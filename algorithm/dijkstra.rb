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

# 確定した頂点を管理する配列
fixed = Array.new(h) { Array.new(w, false) }

queue = [[sx, sy, 0]]

# 優先度付きキューを表現するために、キューの順序がコスト順になるようにする
# bsearch_indexメソッドを使用することで、効率の良い二分探索で挿入位置を見つけられる
def insert_node(queue, node)
  index = queue.bsearch_index { |n| n[2] > node[2] } || queue.length
  queue.insert(index, node)
end

while !queue.empty?
    x, y, d = queue.shift
    # d: 頂点(x, y)までの最短距離
    # 未確定の頂点のうち距離が最も短い頂点をqueueから取り出して最短距離を確定させる
    # 後の処理で確定済みの頂点に訪問した場合はスキップする
    next if fixed[y][x]
    fixed[y][x] = true
    
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
