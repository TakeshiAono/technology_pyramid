FactoryBot.define do
  factory :technology do
    name {'test'}
    public_flag {true}
    basic_flag {true}
    association :work
  end
end
