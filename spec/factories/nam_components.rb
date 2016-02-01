FactoryGirl.define do
  factory :nam_component do
    component_type 'idp'
    name Faker::Internet.domain_word
  end

  trait :idp do
    component_type 'idp'
  end

  trait :ag do
    component_type 'ag'
  end

end
