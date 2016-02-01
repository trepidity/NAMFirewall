require 'rails_helper'

RSpec.describe NetworkDetailsController, type: :controller do
  let(:detail) { Factory.create(:network_detail) }
  subject { detail }

  context "JSON" do

    before do
      request.env['CONTENT_TYPE'] = 'application/json'
    end

    it "should respond with a 200" do
      json = { :format => 'json', :network_detail => { :fw_separates_idp => "1" } }
      post :create, json
      expect(response.status).to eq(200)
      expect(NetworkDetail.first.rule_model.id).to_not eql ''
      expect(NetworkDetail.count).to eql 1
    end

    it "firewall separates IDP true" do
      json = { :format => 'json', :network_detail => { :fw_separates_idp => "1" } }
      post :create, json
      expect(NetworkDetail.first.fw_separates_idp).to be true
    end

    it "firewall separates AG false" do
      json = { :format => 'json', :network_detail => { :fw_separates_idp => '1' } }
      post :create, json
      expect(NetworkDetail.first.fw_separates_ag).to be nil
    end

    it "firewall separates AG true" do
      json = { :format => 'json', :network_detail => { :fw_separates_ag => '1' } }
      post :create, json
      expect(NetworkDetail.first.fw_separates_ag).to be true
    end

    it "firewall separates AC true" do
      json = { :format => 'json', :network_detail => { :fw_separates_ac => '1' } }
      post :create, json
      expect(NetworkDetail.first.fw_separates_ac).to be true
    end

  end

end
