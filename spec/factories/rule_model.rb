FactoryGirl.define do
  factory :rule_model do
    session_id 1
    network_detail
    nam_components
  end

  # trait :network_detail do
  #   after create do |rule|
  #     FactoryGirl.create(:network_detail, :fw_separates_idp => true, :fw_separates_ag => true, :rule_model => rule)
  #   end
  # end

  trait :nam_components do
    after :create do |rule|
      FactoryGirl.create(:nam_component, :component_type => 'idp', :ipaddress => '192.168.0.2', :rule_model => rule)
      FactoryGirl.create(:nam_component, :component_type => 'idp', :ipaddress => '192.168.0.3', :rule_model => rule)

      FactoryGirl.create(:nam_component, :component_type => 'ag', :ipaddress => '192.168.1.2', :rule_model => rule)
      FactoryGirl.create(:nam_component, :component_type => 'ag', :ipaddress => '192.168.1.3', :rule_model => rule)

      FactoryGirl.create(:nam_component, :component_type => 'admin', :ipaddress => '10.10.1.2', :rule_model => rule)
      FactoryGirl.create(:nam_component, :component_type => 'admin', :ipaddress => '10.10.1.3', :rule_model => rule)
    end
  end

end
