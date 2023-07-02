# renderメソッドのcollecitonオプションについて
  
## まず、コレクションとは
コレクションとは、単なる配列ではなく、DBから取得したレコードを格納したもの。

## collectionオプションへの書き換え
```
# localsオプションを使った、基本的な書き方
<%= render(partial: 'パーシャル名', locals: { パーシャルで使うローカル変数local:パーシャルで使うローカル変数に渡す変数var }) %>

# 一般的な書き方
<%= render 'パーシャル名', local: var %>

# localsオプションを使って、@tweetsをtweetパーシャルを使ってすべてレンダリングする
<% @tweets.each do |tweet| %>
  <%= render 'tweet', tweet: tweet %>
<% end %>

# collectionオプションを使って書き換える
<%= render 'tweet', collection: @tweets %>

# collectionオプションの省略記法
<%= render @tweets %>
```

## なぜ`render @tweets`だけで成立するのか
・collectionオプションで指定したオブジェクトの*モデル名*を参照して、呼び出すパーシャルを決めているから  
・上の例では、@tweetsはTweetモデルのコレクションなので、tweetパーシャルが呼び出される　　
・この仕組みによって、コレクションを指定するだけで、パーシャルが自動で呼び出されている　　
・繰り返し表示されるパーシャルのファイル名は、それに対応したモデル名にすると楽出来る！
