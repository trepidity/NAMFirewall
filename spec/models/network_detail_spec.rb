require 'rails_helper'

RSpec.describe NetworkDetail, type: :model do
  let(:detail) { create(:network_detail) }

  subject { detail }

  context 'valid object' do
    it 'is valid' do
      expect(subject.valid?)
    end

  end

end
