require 'rails_helper'

RSpec.describe RuleModel, type: :model do
  let(:rule_model) { create(:rule_model) }
  subject { rule_model }

  context 'valid object' do
    it 'is valid' do
      expect(subject.valid?)
    end

    it 'fw_separates_idp' do
      expect(subject.network_detail.fw_separates_idp).to be true
    end

    it 'contains an idp' do
      expect(subject.idps.count).to eql 2
    end

  end

  context 'builds' do
    let(:rule_model) { create(:rule_model) }
    subject { rule_model }

    it 'ports for FW separating the IDPs' do
      expect(subject.rules.first.dest).to eql '192.168.0.3'
      expect(subject.rules.first.port).to eql [7801, 7802]
    end

    it 'builds the correct number of rules' do
      expect(subject.rules.count).to eql 18
    end

    it 'builds rules for FWs separating the AGs' do
      subject.network_detail.update(:fw_separates_ag => true)
      expect(subject.rules.count).to eql 20
    end

  end

end
