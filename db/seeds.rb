# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

i = 0
k = 0

User.create!(
  name: 'guest',
  email: 'guest@example.com',
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  industry: '製造業',
  occupation: '設計',
  admin: true
)

4.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'aoao0101',
    password_confirmation: 'aoao0101',
    industry: Faker::IndustrySegments.industry,
    occupation: User::OCCUPATION[rand(0..5)]
  )
end

work_example = %w[rails ruby php python laravel]
User.count.times do
  i += 1
  k = 0
  5.times do
    Work.create!(
      title: work_example[k],
      public_flag: true,
      user_id: i,
      active_flag: true
    )
    k += 1
  end
end

technology_example = %w[プログラミング言語 ruby クラス インスタンス クラスメソッド rails ruby]

basic_technology_example = %w[インスタンス変数 selfメソッド アクセスメソッド プライベートメソッド パブリックメソッド]
k = 0
5.times do
  Technology.create!(
    name: technology_example[k],
    public_flag: true,
    work_id: 1,
    basic_flag: false
  )
  k += 1
end

k = 0
5.times do
  Technology.create!(
    name: basic_technology_example[k],
    public_flag: true,
    work_id: 1,
    basic_flag: true
  )
  k += 1
end

k = 2
5.times do
  Hierarcky.create!(
    technology_id: 1,
    lower_technology_id: k,
    access_counter: k,
    good_counter: k
  )
  k += 1
end

k = 3
5.times do
  Hierarcky.create!(
    technology_id: 2,
    lower_technology_id: k,
    access_counter: k,
    good_counter: k
  )
  k += 1
end

k = 4
5.times do
  Hierarcky.create!(
    technology_id: 3,
    lower_technology_id: k,
    access_counter: k,
    good_counter: k
  )
  k += 1
end
Hierarcky.find(2).destroy
Hierarcky.find(3).destroy
Hierarcky.find(4).destroy
Hierarcky.find(5).destroy
Hierarcky.find(7).destroy
Hierarcky.find(8).destroy
Hierarcky.find(10).destroy
Hierarcky.find(13).destroy
Hierarcky.find(6).update(technology_id: 1)

# k = 1
# 5.times do
#   Pyramid.create!(
#     parent_technology_id: 1,
#     child_technology_id: k,
#     public_flag: true,
#   )
#   k += 1
# end

Link.create!(
  title: 'クラスについて（qiita記事）',
  url: 'https://qiita.com/shizen-shin/items/09cf07f9b9f5c4977a14',
  technology_id: 2
)

Link.create!(
  title: 'クラスの基礎知識まとめ（qiita記事）',
  url: 'https://qiita.com/naotospace/items/654b285a7bcbd82b1cff',
  technology_id: 2
)

Link.create!(
  title: 'クラスの概念整理してみた（qiita記事）',
  url: 'https://qiita.com/kohei_04/items/df462ac6578c0fb670bc',
  technology_id: 2
)

Link.create!(
  title: 'クラス毎のよく使う操作まとめ（qiita記事）',
  url: 'https://qiita.com/ren0826jam/items/24d28839d307ffa825fc',
  technology_id: 2
)

Link.create!(
  title: 'クラスとインスタンスの違い（qiita記事）',
  url: 'https://qiita.com/yamaday0u/items/dca132e46b390c9af51b',
  technology_id: 2
)

# LinkAccessCounter.create!(
#   pyramid_id: 1,
#   link_id: 1,
#   counter: 2000
# )

# LinkAccessCounter.create!(
#   pyramid_id: 1,
#   link_id: 2,
#   counter: 300
# )

# LinkAccessCounter.create!(
#   pyramid_id: 1,
#   link_id: 3,
#   counter: 500
# )
# LinkAccessCounter.create!(
#   pyramid_id: 1,
#   link_id: 4,
#   counter: 80
# )
# LinkAccessCounter.create!(
#   pyramid_id: 1,
#   link_id: 5,
#   counter: 300
# )
