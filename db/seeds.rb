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
  name: "aono", 
  email: "aono0321@yahoo.co.jp", 
  password: "aoao0101",
  password_confirmation: "aoao0101",
  industry: "製造業",
  occupation: "設計",
  admin: true
)

4.times do 
  User.create!(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: "aoao0101",
    password_confirmation: "aoao0101",
    industry: Faker::IndustrySegments.industry,
    occupation: User::OCCUPATION[rand(0..5)]
  )
end


work_example = ['rails', 'ruby', 'php', 'python', 'laravel']
User::count.times do
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

technology_example = ['クラス', 'インスタンス', 'クラスメソッド', 'rails', 'ruby', 'インスタンス変数', 'selfメソッド','アクセスメソッド','プライベートメソッド','パブリックメソッド']
k = 0
10.times do
  Technology.create!(
    name: technology_example[k], 
    public_flag: true,
    work_id: 1,
    basic_flag: false
  )
  k += 1
end

k = 1
5.times do
  Pyramid.create!(
    parent_technology_id: 1, 
    child_technology_id: k, 
    public_flag: true,
  )
  k += 1
end
