# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  [
    { email: "admin@admin.com", password: "adminadmin" }
  ]
)

users = User.create!(
  [
    { email: "test1@test.com", name: "はなこ", password: "password", introduction: "よろしくお願いします。", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"), filename: "sample-user1.png") },
    { email: "test2@test.com", name: "いちろう", password: "password", introduction: "旅行大好きです！", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename: "sample-user2.png") },
    { email: "test3@test.com", name: "たろう", password: "password", introduction: "旅の思い出を共有したいです。", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"), filename: "sample-user3.png") },
    { email: "test4@test.com", name: "よしこ", password: "password", introduction: "", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.png"), filename: "sample-user4.png") },
    { email: "test5@test.com", name: "ゆう", password: "password", introduction: "たくさん投稿していきたい！", profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.png"), filename: "sample-user5.png") }
  ]
)


tags = Tag.create!(
  [
    { name: "観光地" },
    { name: "飲食店" },
    { name: "カフェ" },
    { name: "空港内"},
    { name: "お子様連れにも安心" },
    { name: "その他" }
  ]
)


posts = Post.create!(
  [
    { title: "伊丹空港展望デッキ", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename: "sample-post1.jpg"), body: "子供と一緒に間近で飛行機が見れて楽しいですよ！", address: "大阪府豊中市螢池西町3-555", airport: "伊丹空港", is_draft: false, user_id: users[0].id },
    { title: "みっちゃん", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename: "sample-post2.jpg"), body: "広島空港でお好み焼きといえば、ここ！", address: "広島県三原市本郷町善入寺64−31", airport: "広島空港", is_draft: false, user_id: users[1].id },
    { title: "鉄板ジョニー", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename: "sample-post3.jpg"), body: "羽田からすぐ！せんべろができます！", address: "東京都大田区羽田1-15−16", airport: "羽田空港", is_draft: false, user_id: users[2].id },
    { title: "Chocolatier Masale", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename: "sample-post6.jpg"), body: "空港内にあり、ブラウニーもアイスも美味しい！", address: "ショコラティエマサール　新千歳空港出発ロビー店", airport: "札幌新千歳空港", is_draft: false, user_id: users[3].id },
    { title: "コム・シノワ", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post8.jpg"), filename: "sample-post8.jpg"), body: "焼きたてのパンが食べられました。\n8時から開いているのでありがたかったです。", address: "兵庫県神戸市中央区御幸通7-1-15", airport: "神戸空港", is_draft: false, user_id: users[4].id },
    { title: "むつか堂", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename: "sample-post7.jpg"), body: "空港から10分！\n博多駅の駅ビルにあります。\n食パン専門店なので本当に美味しいです！", address: "福岡県福岡市博多区博多駅中央街1-1 アミュプラザ博多5F", airport: "福岡空港", is_draft: false, user_id: users[0].id },
    { title: "重乃井", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post9.jpg"), filename: "sample-post9.jpg"), body: "100年続く老舗\nうどんを食べた後に蕎麦湯のように出汁をいただきます。\nシンプルですごく美味しかった〜！\n宮崎空港からタクシーで20分です。", address: "宮崎県宮崎市川原町8-19", airport: "宮崎空港", is_draft: false, user_id: users[3].id },
    { title: "ガラスの砂浜", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.png"), filename: "sample-post5.png"), body: "日差しを受けると砂浜全体が海の水面と同じようにキラキラでした。", address: "長崎県大村市森園町", airport: "長崎空港", is_draft: false, user_id: users[1].id },
    { title: "你好本店", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post10.jpg"), filename: "sample-post10.jpg"), body: "蒲田の餃子といえばここ\n羽田空港から電車で10分ほど、駅から徒歩5分で着きます！", address: "你好本店", airport: "羽田空港", is_draft: false, user_id: users[4].id },
    { title: "AIMAI", post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename: "sample-post4.jpg"), body: "おしゃれなカフェでした。カフェラテも美味しい！", address: "福岡県福岡市博多区博多駅前4-32-14", airport: "福岡空港", is_draft: false, user_id: users[2].id }
  ]
)

PostTag.create!(
  [
    { post_id: posts[0].id, tag_id: tags[3].id },
    { post_id: posts[0].id, tag_id: tags[4].id },
    { post_id: posts[1].id, tag_id: tags[1].id },
    { post_id: posts[1].id, tag_id: tags[3].id },
    { post_id: posts[2].id, tag_id: tags[1].id },
    { post_id: posts[3].id, tag_id: tags[2].id },
    { post_id: posts[3].id, tag_id: tags[3].id },
    { post_id: posts[4].id, tag_id: tags[2].id },
    { post_id: posts[5].id, tag_id: tags[1].id },
    { post_id: posts[5].id, tag_id: tags[2].id },
    { post_id: posts[6].id, tag_id: tags[1].id },
    { post_id: posts[6].id, tag_id: tags[4].id },
    { post_id: posts[7].id, tag_id: tags[0].id },
    { post_id: posts[7].id, tag_id: tags[4].id },
    { post_id: posts[8].id, tag_id: tags[1].id },
    { post_id: posts[9].id, tag_id: tags[1].id },
    { post_id: posts[9].id, tag_id: tags[2].id }
  ]
)