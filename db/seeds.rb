# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  [
    {email: 'admin@admin.com', password: 'adminadmin'}
  ]
)

users = User.create!(
  [
    {email: 'test1@test.com', name: 'はなこ', password: 'password', introduction: 'よろしくお願いします。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"), filename:"sample-user1.png")},
    {email: 'test2@test.com', name: 'いちろう', password: 'password', introduction: '旅行大好きです！', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename:"sample-user2.png")},
    {email: 'test3@test.com', name: 'たろう', password: 'password', introduction: '旅の思い出を共有したいです。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"), filename:"sample-user3.png")}
  ]
)


tags = Tag.create!(
  [
   {name: '観光地'},
   {name: '飲食店'},
   {name: 'カフェ'},
   {name: 'お子様連れにも安心'},
   {name: 'その他'}
  ]
)


Post.create!(
  [
    {title: '伊丹空港展望デッキ', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), body: '子供と一緒に間近で飛行機が見れて楽しいですよ！', address: '大阪府豊中市螢池西町3-555', airport: '伊丹空港', is_draft: false, tag_id: tags[3].id, user_id: users[0].id },
    {title: 'みっちゃん', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), body: '広島空港でお好み焼きといえば、ここ！', address: '広島県三原市本郷町善入寺64−31', airport: '広島空港', is_draft: false, tag_id: tags[1].id, user_id: users[1].id },
    {title: '鉄板ジョニー', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), body: '羽田からすぐ！せんべろができます！', address: '東京都大田区羽田1-15−16', airport: '羽田空港', is_draft: false, tag_id: tags[1].id, user_id: users[2].id },
    {title: 'AIMAI', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg"), body: 'おしゃれなカフェでした。カフェラテも美味しい！', address: '福岡県福岡市博多区博多駅前4-32-14', airport: '福岡空港', is_draft: false, tag_id: tags[2].id, user_id: users[0].id },
    {title: 'ガラスの砂浜', post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.png"), filename:"sample-post5.png"), body: '日差しを受けると砂浜全体が海の水面と同じようにキラキラでした。', address: '長崎県大村市森園町', airport: '長崎空港', is_draft: false, tag_id: tags[0].id, user_id: users[1].id }
  ]
)