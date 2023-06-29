## has_many through関連付けのまとめ

### userモデルとpostモデルが中間テーブルlikeを持つ
・userとpostは「1対多」  
・あるuserは複数のpostをlikeできるので、「1対多」  
・あるpostは複数のuserからlikeされるので、「1対多」  
・userとpostが「多対多」の関係になるので、中間テーブルlikeを介することで、userとlike・postとlikeそれぞれが「1対多」の関係になる  

```
# user.rb
has_many :posts
has_many :likes
has_many :like_posts, through: :likes, source: :post

# post.rb
belongs_to :user
has_many :likes
has_many :users, through: :likes

# like.rb
belongs_to :user
belongs_to :post
```

### 呼び出し方
・あるuserが作成したpostの一覧 => `user.posts`  
・あるpostを作成したuser => `post.user`  
・あるuserがlikeしたpostの一覧 => `user.like_posts`  
・あるpostにlikeしたuserの一覧 => `post.users`  

### 注意点
・userモデルからpostモデルへの関連付けが2つあるので、どちらで関連付けで呼び出してるか分かるようにする  
・中間テーブルlikeを介した関連付けをlike_postsとすることで、`user.like_posts`という呼び出し方が可能に  
・このままだとlike_postsテーブルを検索対象にしてしまうので、`source: :post`でpostテーブルを探索するように指定  
・has_manyやbelongs_toで指定した部分を見ると、どこから何を呼び出せるかよく分かる  
