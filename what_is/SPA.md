## SPAとは

### 概要
SPAとは、"Single Page Application"の略称。<br/>
単一のWebページだけでアプリケーションを構成する設計手法。<br/>
- 最初だけHTMLを取得し、変更が必要な部分はJavaScriptで書き換えることで画面の動作と描画をコントロールするため、その名の通り一つのHTMLファイルで成り立っている
- Ajax通信で非同期に必要なデータだけを受け取りコンテンツを更新する
- JavaScriptによってURLを操作できる（Histroy API）ので、URLの変更をイベントとして検知し画面を書き換えることも可能
- Vue.js や React を用いてビュー部分のデータ（JSON）をブラウザに渡し、サーバーサイドではAPIのみを提供しページの構築を行う
- JavaScriptによってURLを操作できるので、URLの変更をイベントとして検知し画面を書き換えることも可能 
<br/>

### メリット
- 高速なページ遷移

ページ全体を更新するのではなく、ユーザーのアクションに応じて必要な部分だけを書き換えるのでページ遷移が高速。
- UXの向上
  - アニメーションによる滑らかなページ遷移
  - 画面の一部だけを書き換えるので、あるコンテンツ（例えば、音楽再生）を利用したまま他のコンテンツを表示するといったことが可能

上記2つの恩恵として、ユーザーの離脱率が低下する。

<br/>


### デメリット
- ページの初期読み込みに時間がかかる

ページ遷移やコンテンツの表示を担うJavaScriptのコード量が増えるため、読み込みに時間がかかる。<br/>
SSR（サーバーサイドレンダリング）を導入することで対策可能だが、実装コストが増える。

- SEOで不利になる可能性がある

単一のページでアプリケーションを構成するという設計上、検索エンジンのクローラーが読み込むHTMLが一つしかないため。<br/>
そのため、ログインを前提とする会員制Webサービスなどの構築に向いており、PVを集めたいWebメディアなどには不向き。
SSR(Server Side Rendering)や*Dynamic Renderingでクローラが読み込みやすいHTMLを別に生成するといった回避策がある。

*Dynamic Rendering（ダイナミックレンダリング、動的レンダリング）<br/>
クローラーに対してあらかじめJavaScript処理を済ませたページを出し分けする実装手法のこと。<br/>
仕組みがより複雑になり、多くのリソースが必要になるので、非推奨の解決策らしい。

<br/>

### 参考文献
- [SPAについてまとめてみた](https://qiita.com/hisashi_matsui/items/bd945fb85d8596172811)
- [SPAってページ遷移するの？](https://qiita.com/ozaki25/items/41e3af4679c81a204284)
- [【図解】SPA (Single Page Application) の仕組みと構成例、メリット/デメリット](https://milestone-of-se.nesuke.com/sv-basic/web-tech-basic/single-page-application/)
- [SPA開発とは？メリットや主要なフレームワークを紹介します](https://relace.co.jp/blog/spadevelopment)
- [SPA（Single Page Application）の意味を徹底解説します！](https://www.profuture.co.jp/mk/column/28468)
- [SPA(Single Page Application)とは](https://www.headwaters.co.jp/service/spa.html)
- [回避策としてのダイナミック レンダリング](https://developers.google.com/search/docs/crawling-indexing/javascript/dynamic-rendering?hl=ja)
