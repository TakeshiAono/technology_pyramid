FactoryBot.define do
  factory :link do
    sequence(:title) {|n| "link_test#{n}"}
    url {'https://github.com/TakeshiAono/technology_pyramid'}
    good_counter {1}
    association :technology
  end
end
