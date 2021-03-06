require 'rails_helper'

describe 'ShopSlot model' do
  let(:shop_slot) { FactoryBot.create(:shop_slot) }

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
      it 'shop slot should be valid' do
        shop_slot
        expect(shop_slot).to be_valid
      end
    end

    describe 'verifiy day' do
      before { shop_slot.day = nil }
      it 'should be present' do
        expect(shop_slot).to_not be_valid
      end
    end

    describe 'verifiy opening hour' do
      before { shop_slot.open_hour = '' }
      it 'should be present' do
        expect(shop_slot).to_not be_valid
      end
    end

    describe 'verifiy closing hour' do
      before { shop_slot.close_hour = '' }
      it 'should be present' do
        expect(shop_slot).to_not be_valid
      end
    end

    describe 'verifiy number of appointments' do
      before { shop_slot.max_appointments = 51 }
      it 'should be present' do
        expect(shop_slot).to_not be_valid
      end
    end
  end
end
