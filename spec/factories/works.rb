FactoryBot.define do
  factory :work do
    title {'test'}
    public_flag {true}
    active_flag {true}
    association :user
  end
end
