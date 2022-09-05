FactoryBot.define do
  factory :link do
    title {'test'}
    url {'https://github.com/TakeshiAono/technology_pyramid'}
    good_counter {1}
    association :technology
  end
end
