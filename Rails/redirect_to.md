# redirect_toメソッド

### 概要

- リダイレクト先のURLをlocationヘッダーに記載したレスポンスを返す
- クライアントはそのレスポンスを元に、再度リクエストを送信する
- データの作成、更新、削除など、ページの表示を目的としないリクエストに対してリダイレクトを使う

### renderメソッドとの違い

- renderメソッドは単にレスポンスを返すだけ
- redirect_toメソッドは、一旦リダイレクト先を指定したレスポンスを返し、クライアントに再度リクエストを送信するように要求する
- クライアントが再度リクエストを送信するので、コントローラを経由してレスポンスが返される
- コントローラを経由した時に、**インスタンス変数が初期化される**ので、フォームの入力値が保持されない
- renderメソッドは単にレスポンスを返すだけだから、コントローラ内で定義したインスタンス変数は保持されたままなので、フォームの入力値が保持される

### destroyアクションで使う時の注意点

- Rails7系ではturboが採用されているので、destroyアクションのレスポンスには`status: :see_other`をつける必要がある

```ruby
def destroy
  @user = User.find(params[:id])
  user.destroy!
  redirect_to users_path, status: :seeother
end
```

- `status: :see_other`をつけないと、リダイレクト先のURLにDELETEメソッドで遷移してしまい、404エラーが発生したり予期せぬリソースを削除してしまう場合がある

### 参考文献

- status: :see_other<br/>
[https://qiita.com/jnchito/items/5c41a7031404c313da1f#destroyのレスポンスに-status-see_other-を付ける必要がある]
