require 'rails_helper'

describe 'Appointment model' do
  let(:user) { FactoryBot.create(:user) }
  let(:shop) { FactoryBot.create(:shop_with_shop_slots) }
  let(:appointment) { FactoryBot.create(:appointment, shop: shop, user: user) }

  describe 'associations' do
    describe 'user' do
      assoc = Appointment.reflect_on_association(:user).macro
      subject { assoc }
      it 'should belong_to' do
        expect(subject).to eq(:belongs_to)
      end
    end
  end

  describe 'associations' do
    describe 'shop' do
      assoc = Appointment.reflect_on_association(:shop).macro
      subject { assoc }
      it 'should belong_to' do
        expect(subject).to eq(:belongs_to)
      end
    end
  end

  describe 'validations' do
    describe 'control test' do
      it 'appointment should be valid' do
        expect(appointment).to be_valid
      end
    end

    describe 'date should be mandatory' do
      before { appointment.date = nil }
      it 'should be present' do
        expect(appointment).to_not be_valid
      end
    end
  end
end
