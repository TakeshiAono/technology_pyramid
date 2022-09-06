FactoryBot.define do
  factory :hierarcky do
    lower_technology_id {nil}
    access_counter {1}
    good_counter {1}
    association :technology
  end
end
