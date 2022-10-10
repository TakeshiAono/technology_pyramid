FactoryBot.define do
  factory :favorite do
    user_id { :user }
    favorite_id { :second_user }
  end
end
