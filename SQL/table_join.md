# テーブルの結合

### 概要

- テーブルの結合には5種類ある
    - 内部結合 INNER JOIN
    - 外部結合
        - 左外部結合 LEFT OUTER JOIN
        - 右外部結合 RIGHT OUTER JOIN
        - 完全外部結合 FULL OUTER JOIN
    - 交差結合 CROSS JOIN
- DBMSによって差異がある
    - MySQLでは完全外部結合が使えないらしい

### 使用テーブル

- usersテーブル

| id | name | age |
| --- | --- | --- |
| 1 | John | 28 |
| 2 | Oliver | 44 |
| 3 | Amanda | 32 |
| 4 | Ethan | 21 |
| NULL | Mark | 37 |
- postsテーブル

| id | title | user_id |
| --- | --- | --- |
| 1 | holidays | 1 |
| 2 | SNS | 4 |
| 3 | meeting | 3 |
| 4 | baseball | 2 |
| 5 | espors | 4 |
| 6 | Beer Party! | NULL |

### テーブル結合の挙動

```sql
SELECT *
FROM 結合元のテーブル（左）
JOIN 結合先のテーブル（右）
ON テーブルの結合条件
```

- FROMで指定したテーブルだけでなく、結合先のテーブルのカラムもSELECTで指定出来るようになる

### 内部結合 INNER JOIN

- ただ`JOIN`だけで結合した場合は、INNER JOINになる
- 右テーブルの行数に合わせて、左テーブルのレコードを複製する
- 結合相手がいないレコードは結合結果に含まれない
    - 結合条件のどちらかのカラムがNULLの場合など

usersテーブルとpostsテーブルを内部結合する：

```sql
SELECT *
FROM users
JOIN posts
on users.id = post.user_id
```

実行結果：

| id | name | age | id | title |
| --- | --- | --- | --- | --- |
| 1 | John | 28 | 1 | holidays |
| 4 | Ethan | 21 | 2 | SNS |
| 3 | Amanda | 32 | 3 | meeting |
| 2 | Oliver | 44 | 4 | baseball |
| 4 | Ethan | 21 | 5 | esports |
- 右テーブルの件数に合わせて、左テーブルのレコードが増えている
- Markはidが、Beer Party!はuser_idがNULLなので、結合結果から消えている

### 外部結合

- 内部結合とは異なり、値がNULLのレコードも取得出来る
- 左外部結合、右外部結合、完全外部結合の3種類がある

### LEFT OUTER JOIN（左外部結合）

- `LEFT JOIN`を使って結合する
- 左テーブルの行は強制的に全て取得する
- 右テーブルに結合相手がない場合は、値がNULLである行を生成する

usersテーブルとpostsテーブルをLEFT JOINする：

```sql
SELECT *
FROM users
LEFT JOIN posts
ON user.id = posts.user_id
```

実行結果：

| id | name | age | id | title |
| --- | --- | --- | --- | --- |
| 1 | John | 28 | 1 | holidays |
| 4 | Ethan | 21 | 2 | SNS |
| 3 | Amanda | 32 | 3 | meeting |
| 2 | Oliver | 44 | 4 | baseball |
| 4 | Ethan | 21 | 5 | esports |
| NULL | Mark | 37 | NULL | NULL |
- 左テーブル（users）のレコードは全て表示される
    - 右テーブルのBeer party!は結果に含まれていない
- Markに対応する右テーブルのレコードはないので、NULLで補完されている

### RIGHT OUTER JOIN（右外部結合）

- `RIGHT JOIN`を使って結合する
- 右テーブルのレコードは全て表示する
- 対応する左テーブルがなければ、NULLで補完される

userテーブルとpostsテーブルをRIGHT JOINする：

```sql
SELECT *
FROM users
RIGHT JOIN posts
ON user.id = posts.user_id
```

実行結果：

| id | name | age | id | title |
| --- | --- | --- | --- | --- |
| 1 | John | 28 | 1 | holidays |
| 4 | Ethan | 21 | 2 | SNS |
| 3 | Amanda | 32 | 3 | meeting |
| 2 | Oliver | 44 | 4 | baseball |
| 4 | Ethan | 21 | 5 | esports |
| NULL | NULL | 37 | 6 | Beer party! |
- 右のテーブル（posts）は全て表示されている
    - 左テーブルのMarkは結果に含まれていない
- Beer party!の行は対応する左テーブルがないので、NULLで補完されている

とりあえず、詳細は内部結合と左右外部結合まで

### 完全外部結合

- 左右のテーブルの全てのレコードを表示する

### 交差結合

- 左右テーブルのレコードの組み合わせを列挙する
    
    ⇒ 順列と組み合わせが得られる
    

### 参考文献

[【INNER JOIN, LEFT JOIN , RIGHT JOIN】テーブル結合の挙動をまとめてみた【SQL】](https://qiita.com/ngron/items/db4947fb0551f21321c0)

[【SQL】結合入門（クロス結合、内部結合、外部結合）](https://qiita.com/aki3061/items/e9e7c37d59991c7aa3c2)
