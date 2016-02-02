FactoryGirl.define do
  factory :nam_component do
    component_type 'idp'
    name Faker::Internet.domain_word
    ipaddress Faker::Internet.ip_v4_address
  end

  trait :idp do
    component_type 'idp'
  end

  trait :ag do
    component_type 'ag'
  end

  trait :admin do
    component_type 'admin'
  end

end
