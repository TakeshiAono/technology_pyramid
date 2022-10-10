FactoryBot.define do
  factory :work do
    title {'test'}
    public_flag {true}
    active_flag {true}
    association :user
  end

  factory :second_work, class: Work do
    title {'test2'}
    public_flag {true}
    active_flag {true}
    # association :second_user
  end
end
