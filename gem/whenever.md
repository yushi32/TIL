## gem 'whenever'とは
- cron

「クロン」または「クーロン」と呼ばれる、定期的にコマンドを実行するためにメモリ場で常に命令を待機しているプロセス。<br/>
この`cron`に対して命令を行うには、`crontab`に記述する必要がある。<br/>
※ UNIX系のOSには、cronが標準で備わっている。

- whenever
  
gem 'whenever'は、`cron`の設定をRubyの文法で扱えるようにしたライブラリ。<br/>
つまり、wheneverを使えば`cron`に対して命令を出す`crontab`をRuby言語で書けるようになる。

### インストール
1. Gemfileに以下の記述を追加:
```ruby
gem 'whenever', require: false
```
2. `$ bundle install`を実行
3.  定期実行する処理の設定ファイルを生成する:
```
$ bundle exec whenverize .
```
`config/schedule.rb`が作成されて、ログに`[done] wheneverized!`が表示されていれば成功。

### 定期実行処理の作成
- 設定できる`job_type`

デフォルトで4種類の`job_type`を設定できる。
```ruby
command: bashコマンド実行
rake: rakeタスク実行          #=> rake '名前空間:タスク名'
runner: Rails内のメソッド実行   #=> runner 'モデル名.メソッド名'
script: scriptの実行
```
自作の`job_type`を定義することもできる。

- 定期実行の間隔の指定
  
```ruby
# 時間間隔の指定
every 3.hours do # 1.minute 1.day 1.week 1.month 1.year is also supported
  定期実行したい処理 # rake 'greet:hello', runner 'User.hoge'　など
end


# 時刻の指定
every 1.day, at: '4:30 am' do
  ...
end

every 1.day, at: ['4:30 am', '6:00 pm'] do
  ...
end


# 毎時間・日・月・年などの指定
every :hour do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  ...
end


# 一週間の中での指定
every :sunday, at: '12pm' do # Use any day of the week or :weekend, :weekday
  ...
end
```

- cronの実行関連の指定

  

### crontabに書き込む
定期実行処理は`crontab`をもとに実行されるので、`config/schedule.rb`に記述した内容を`crontab`に反映させる必要がある。<br/>
そのためには、以下のコマンドを実行する:
```
$ whenever --update-crontab
```

### その他crobtab関連のコマンド
- 設定内容にエラーがないか確認
```
$ bundle exec whenever
```

- 設定されているcronを見る
```
$ crontab -l
```

- crontabの設定削除（定期実行を辞めたいとき）
```
$ bundle exec whenever --clear-crontab
```


### 参考文献
GitHub: https://github.com/javan/whenever

【Rails】wheneverでcronを設定: https://qiita.com/mmaumtjgj/items/19e866f31541abb6c614

gem whenever を使って Rails で定時処理を作る: https://qiita.com/hirotakasasaki/items/3b31966294a809b99c4c
