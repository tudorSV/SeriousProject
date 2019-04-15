require 'rails_helper'
require 'pry'

describe 'Appointment model' do
  let(:user) { FactoryBot.create(:user) }
  let(:shop) { FactoryBot.create(:shop) }
  let(:shop_slot1) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot2) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot3) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot4) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot5) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot6) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot7) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:appointment) { FactoryBot.create(:appointment, shop: shop, user: user) }

  before do
    shop_slot1
    shop_slot2
    shop_slot3
    shop_slot4
    shop_slot5
    shop_slot6
    shop_slot7
  end

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
