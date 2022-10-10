FactoryBot.define do
  factory :user do
    name {'example'}
    sequence (:email) { |n| "guest#{n}@example.com"}
    admin {true}
    password {"example"}
    password_confirmation {"example"}
  end
end
