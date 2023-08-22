## Rakeとは
Rakeとは、Rubyで実装されたMake（UNIX系のOSで使用できるコマンド）のようなビルド作業を自動化するプログラムのこと。<br/>
プログラム実行をタスクという単位でまとめて扱うことができる。<br/>
ざっくり言えば、まとめて実行したい処理を1つのタスクとして定義し、コマンドラインなどから呼び出しやすくしたもの。<br/>
Railsには標準で`rake`というgemがインストールされていて、独自のRakeタスクを作成することができる。<br/>

* Makeとは

makeコマンドとは、UNIX系OSにおけるプログラム開発で標準的に用いられるコマンドの一つで、ソースコードからの実行ファイルの作成（ビルド）を自動化するもの。<br/>
プログラムの規模が大きくなったり、複雑な構成の場合、多数のファイルをコンパイルしたりリンクする作業が必要となる。<br/>
そのような一連の手順を所定の形式でテキストファイルとして記述しておくと、これに従ってコマンド実行などを連続して自動的に行なってくれる。<br/>
これによって、makeコマンド一回の実行で実行ファイルの作成が完了する。

### 使い方
- タスクの作成

以下のコマンドを実行する。
```ruby
$ rails g task ファイル名

# greetタスクを作成
$ rails g task greet
```

上記コマンドによって、`lib/tasks/greet.task`というファイルが生成される。<br/>
`ファイル名`は生成されるファイルの名前になり、デフォルトの名前空間にもなる。<br/>
複数タスクを記述する場合は、この名前空間を利用してタスクをまとめるのがベター。

- 基本構成
  
タスクファイルの基本的な構成は以下:
```ruby
namespace :ファイル名 do
end

# greet.task
namespace :greet do
end
```
この中に実行する処理を記述していく。
```ruby
namespace :ファイル名 do
  desc 'タスクの説明'
  task :タスク名 do
    実行したい処理
  end
end

# greet.taskにhelloというタスクを追加する
namespace :greet do
  desc 'おはようと挨拶をするタスク'
  task :hello do
    puts 'おはよう'
  end
end
```

- RakeタスクでActiveRecordを扱う場合

taskに`:environment`オプションをつける必要がある。
```ruby
namespace :ファイル名 do
  desc 'タスクの説明'
  task タスク名: :environment do
    実行したい処理
  end
end

# helloというタスクの中でUserモデルを扱う
namespace :greet do
  desc '全員におはようと挨拶をするタスク'
  task helo: :environment do
    users = User.all
    user.each do |user|
      puts "#{user}さん、おはよう"
    end
  end
end
```

### Rakeタスクの実行
以下のコマンドを実行する:
```ruby
$ rails greet:hello
```

### Rakeタスクの確認
実行可能なタスクの一覧は以下のコマンドで確認できる。
```ruby
$ rails -T

rake greet:hello # 実行可能なタスクが表示される
```
この時、自分で作成したRakeタスクだけではなく、`rails db:migrate`などのコマンドも同時に表示される。

`$ rails -T`コマンドで表示されるのは、`desc`で説明が記述されているものだけ。<br/>
説明のないRakeタスクも含めて表示したい場合は、`$ rails -AT`コマンドを使う。

### その他
gem 'whenever'と組み合わせることで、Rakeタスクを任意のタイミングや定期的に実行することが可能になる。

### 参考文献
GitHub: https://github.com/ruby/rake

RubyGems: https://rubygems.org/gems/rake

【Rails 】Rakeタスクとは: https://qiita.com/mmaumtjgj/items/8384b6a26c97965bf047

【Rails】Rakeタスクの基本情報と作成・実行方法: https://autovice.jp/articles/177

【Rails】ControllerからRakeタスクを実行する: https://serip39.hatenablog.com/entry/2022/06/22/070000



