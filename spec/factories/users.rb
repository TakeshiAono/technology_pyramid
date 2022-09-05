FactoryBot.define do
  factory :user do
    name {'example'}
    email {'guest@example.com'}
    admin {true}
    password {"example"}
    password_confirmation {"example"}
  end
end
