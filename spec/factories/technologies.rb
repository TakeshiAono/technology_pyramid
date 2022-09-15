FactoryBot.define do
  factory :technology do
    name {'test_tech'}
    public_flag {true}
    basic_flag {true}
    association :work
  end
end
