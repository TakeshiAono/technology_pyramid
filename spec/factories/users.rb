FactoryBot.define do
  factory :user do
    name {'example'}
    sequence (:email) { |n| "guest#{n}@example.com"}
    admin {true}
    password {"example"}
    password_confirmation {"example"}
    # trait :user_with_work do
    #   after(:build) do |user|
    #     user.works << build(:work)
    #   end
    # end
  end

  # factory :second_user, class: User do
  #   name {'example2'}
  #   email {'guest2@example.com'}
  #   admin {true}
  #   password {"example"}
  #   password_confirmation {"example"}
  # end
end
