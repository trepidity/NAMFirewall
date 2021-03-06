require 'rails_helper'

RSpec.describe NamComponent, type: :model do
  let(:nam_component) { create(:nam_component) }

  context 'valid object' do

    it 'is valid' do
      expect(nam_component.valid?)
    end

    it 'is an ag' do
      expect((create :nam_component, :ag).component_type).to eql 'ag'
    end

    it 'requires a name' do
      expect(build(:nam_component, :name => "").valid?).to be false
    end

    it 'has a valid name' do
      expect(nam_component.name).to_not be nil
    end

    it 'is not in the same DMZ' do
      nam_component.update(:dmz => 'public')
      expect(nam_component.dmz).to eql 'public'
    end

    it 'requires a valid IP address' do
      expect(build(:nam_component, :ipaddress => "192.168.192").valid?).to be false
    end

    it 'does not allow spaces in the name' do
      expect(build(:nam_component, :name => "one two").valid?).to be false
    end

    it 'does not allow spaces in the name' do
      expect(build(:nam_component, :name => "goblxpvidp1").valid?).to be true
    end

  end

end
