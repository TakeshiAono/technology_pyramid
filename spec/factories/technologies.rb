FactoryBot.define do
  factory :technology do
    name { 'test_tech1' }
    public_flag { true }
    basic_flag { true }
    association :work
  end

  factory :second_technology, class: Technology do
    name { 'test_tech2' }
    public_flag { true }
    basic_flag { true }
    association :work
  end
end
