# README
## :blue_book:アプリ名
### フリマアプリ クローン<br>
![8b95bb296ac94d7b04e3344eb0eeb130](https://user-images.githubusercontent.com/56475566/73038902-73159700-3e97-11ea-8653-b82acf214b0b.gif)<br>
url: http://18.177.235.133/
## :blue_book:アプリの概要
フリーマーケットアプリケーションである「メルカリ」のコピーサイトを作成しました。ただ、コピーするだけでなく、オリジナル機能も付けました。
<br>
ID/Pass<br>
ID: admin, Pass: 0601<br>
テスト用アカウント等<br>
購入者用<br>
メールアドレス: sample@buyer.com<br>
パスワード: 123456a<br>
購入用カード情報<br>
番号：4242424242424242<br>
期限：12/20<br>
ユーザー名：YUI ARAGAKI<br>
セキュリティコード：123<br>
出品者用<br>
メールアドレス名: sample@seller.com<br>
パスワード: 123456a<br>

## :blue_book:担当箇所
#### DB設計<br>
#### フロントエンド<br>
トップページ、ユーザーログアウトページ、商品出品ページ、商品購入確認ページ<br>
#### サーバーサイド<br>
商品出品、商品情報編集、商品削除、商品一覧表示、カテゴリ検索機能<br>
#### オリジナル機能<br>
トレンド機能<br>
出品数の多いカテゴリィをランキング形式で表示するようにしました。<br>
データ分析が好きなので、データを使った機能を付けたいと思い実装しました。<br>

## :blue_book:工夫した点
実装に時間を割いて、進捗が遅れないようにした。そのお陰で、気持ち的にも余裕ができて、チームの雰囲気も悪くなることなく、進められました。<br>
メンバーからの相談には積極的に乗るようにした。メンバーが詰まっていそうなら、こちらから声をかけたりして、気を配りました。<br>
実装に関しては、なるべくコードが冗長にならないように、each文で書いたり、ヘルパーメソッドを使ったりするよう努力しました。また、トップページの商品一覧は、商品が多いカテゴリを自動的に表示するように、状況に合わせて、動的に表示できるように実装しました。<br>
オリジナル機能として、トレンド機能を実装しました。商品数の多いカテゴリーをランキング形式で表示します。トップページのトレンドワードをクリックするとランキングページに飛ぶことができます。

## :blue_book:苦労した点
1.サーバーサイドの機能を実装する際に、他人の書いたビューにフォームなどを当てていくのに苦労しました。事前に、クラス名について話し合うべきでした。また、どこを部分テンプレートとするのかを、始めにもっと調査をして決めておけば、実装の時に楽になったと思いました。<br>
ここまで、規模の大きいアプリケーションを作ることやチーム開発が初めてだったのですが、プログラミング技術や知識のなさから、コードを書き始める前の事前準備が大切だと思いました。<br><br>
2.他の人の作業で、実装できていたと思っていた箇所が、実装できていませんでした。これは、タスクをきちんと洗い出していなかったこと、タスクの実装内容や完了条件を明確にしていなかったこと、自分自身できちんと実装できているか確認をしていなかったのが原因です。<br>
言葉だけを信じず、まずは、きちんとタスクを洗い出し、トレロにみんなが把握できるようにタスクを追加し、完了した時には、完了条件を満たしているのかを確認すべきでした。

## :blue_book:開発環境
Ruby on Rails 5.2.4, ruby 2.5.1


## users テーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|self_introduction|text|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|string|null: false|
|birth_month|string|null: false|
|birth_day|string|null: false|
### Association
- has_many :sns_links dependent: :destroy
- has_many :comments dependent: :destroy
- has_many :likes dependent: :destroy
- has_many :reviews dependent: :destroy
- has_many :items dependent: :destroy
- has_one :creditcard
- has_one :address
- has_one :phone_number

##　phone_number　テーブル
|Column|Type|Options|
|------|----|-------|
|phone_number|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user


## address テーブル
|Column|Type|Options|
|------|----|-------|

|zipcode|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|detail_address|string|null: false|
|building|string|-------|
|optional_phone_number|string|-------|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user



## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|state|text|null: false|
|condition|string|null: false|
|price|integer|null: false|
|category_id|integer|null: false, foreign_key: true|
|review_id|integer|null: false, foreign_key: true|
|brand_group_id|integer|null: false, foreign_key: true|
|size_id|integer|null: false, foreign_key: true|
|buyer_id|integer|foreign_key: true|
|seller_id|integer|null: false, foreign_key: true|
### Association
- has_many :images dependent: :destroy
- has_many :likes
- belongs_to :category
- belongs_to :review
- belongs_to :brand_group
- belongs_to :size
- belongs_to :buyer,class_name: "User"
- belongs_to :seller,class_name: "User"
- has_one :shipping dependent: :destroy

## shippingテーブル
|Column|Type|Options|
|------|----|-------|
|method|string|null: false|
|prefecture_from|string|null: false|
|period_before_shopping|string|null: false|
|fee_burden|string|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|comment|text|null: false|
### Association
- belongs_to :user
- belongs_to :item

## reviewsテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
|review|text||
|rate|integer|null: false|
### Association
- belongs_to :user
- belongs_to :item

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item

## sns_link テーブル
|Column|Type|Options|
|------|----|-------|
|security_token|text|null: false|
|uid|text|null: false|
|provider|text|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
-belongs_to :user

## creditcard テーブル
|Column|Type|Options|
|------|----|-------|
|security_token|text|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
-belongs_to :user

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|parent_id|integer|foreign_key: true|
|grandparent_id|integer|foreign_key: true|
### Association
- has_many :items

## brand_groupテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|
### Association
- has_many :items
- has_many :brands

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|
|brand_group_id|references|null: false, foreign_key: true|
### Association
- belongs_to :brand_group

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item



## sizeテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items
