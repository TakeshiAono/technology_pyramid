FactoryBot.define do
  factory :user do
    name {'example'}
    email {'guest@example.com'}
    admin {true}
    password {"example"}
    password_confirmation {"example"}
  end

  factory :second_user, class: User do
    name {'example2'}
    email {'guest2@example.com'}
    admin {true}
    password {"example"}
    password_confirmation {"example"}
  end
end
