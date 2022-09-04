FactoryBot.define do
  factory :user do
    name {'example'}
    email {'guest@example.com'}
    admin {true}
    password {"aoao0101"}
    password_confirmation {"aoao0101"}
  end
end
