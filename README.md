# AIRSUPPORT

![1666001493324](https://user-images.githubusercontent.com/106796386/196151749-ff090a8f-320e-482d-af78-42ff1c393f05.png)

## サイト概要

### サイトテーマ
  旅をする全ての方へ！  
  各地の空港周辺の観光情報やレストラン、カフェなどの情報を投稿したり検索したりできるコミュニティサイト


### テーマを選んだ理由
  元々旅が好きでよく旅行するのですが、最終日などは飛行機の時間までできることが限られていたり、思わぬ遅延で空港で待ちぼうけしてしまった経験がありました。
  また、仕事柄空港周辺で宿泊する経験が多くあったのですが、意外と都市部までは距離があってどこにも行けないな…と諦めてしまうことが多くありました。  
  そこで、空港周辺で時間や体力の心配をせずに、気軽に楽しむことができれば、旅をもっと素敵なものにできるのではないかと考え、このサイトを制作しました。  
  このコミュニティがその土地の魅力を知るきっかけとなり、地域の活性化にも一役買えるようなサービスにできればと思いました。

### ターゲットユーザー
 - 旅を1秒も無駄にすることなく楽しみたい方
 - 旅の思い出を共有したい方
 - 旅行好きな方
 - 地元の魅力を発信したい方
 - レストランやカフェのオーナー様

### 主な利用シーン
- 検索
  - 旅のプラン作成時
  - 空港での待ち時間など、すきま時間にサクッと検索
  - 旅好きの方の情報収集に
- 投稿
  - 旅行での思い出をシェア
  - 地元の魅力を発信
  - レストランやカフェのオーナー様による宣伝

## 設計書

### ER図
![ER図 (1)](https://user-images.githubusercontent.com/106796386/196601217-e2c09a94-ce5c-47e3-9380-fe24b39260e1.jpg)

### AWSシステム構成図
![AWSシステム構成図](https://user-images.githubusercontent.com/106796386/196151335-1ed11995-edb1-4662-9db1-7507183a0a45.jpg)

### その他
- [UI Flows](https://drive.google.com/file/d/1D7TgHl0nmjuLEqufgK1qBxe2b572__s7/view?usp=sharing)
- [ワイヤーフレーム](https://drive.google.com/file/d/1vaFUBP_x4B90DP3prFGON9LMyffXkkO5/view?usp=sharing)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1Tp5NF7XPubGdvODzr5KErdDS83oDe2MVII_KGrHSeE4/edit?usp=sharing)
- [AWSインフラ設計書](https://docs.google.com/spreadsheets/d/1oV8BKiT1ywpfEh-jn5WY0Ps7NCO2_zdVMRPaEfcvftI/edit?usp=sharing)

## 開発環境
- OS：Linux2(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## Gems
- devise：ログイン機能
- geocoder：GoogleAPI導入時の緯度・経度取得
- kaminari：ページネーション
- ransack：検索機能実装
- rubocop：コーディングチェック
- rspec-rails：テスト

## 使用素材
- Font Awesome
- Google Font
- メインビジュアル画像：[Pixabay](https://pixabay.com/ja/)
