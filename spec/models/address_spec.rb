require 'rails_helper'

describe 'Address model' do
  let(:address) { FactoryBot.create(:address) }
  let(:address_short) { FactoryBot.create(:address) }

  describe 'associations' do
    describe 'shop' do
      assoc = Address.reflect_on_association(:shops).macro
      subject { assoc }
      it 'should have_many' do
        expect(subject).to eq(:has_one)
      end
    end
  end

  describe 'validations' do
    describe 'when the short address is not present' do
      before { address.short_address = '' }
      it 'should require a short address' do
        expect(address).to_not be_valid
      end
    end

    describe 'when the short address is too long' do
      before { address.short_address = 'a' * 16 }
      it 'should require a shorter short address' do
        expect(address).to_not be_valid
      end
    end

    describe 'when the full address is too long' do
      before { address.full_address = 'a' * 26 }
      it 'should require a shorter full address' do
        expect(address).to_not be_valid
      end
    end

    describe 'when the city name is too long' do
      before { address.city = 'a' * 21 }
      it 'should require a shorter city name' do
        expect(address).to_not be_valid
      end
    end

    describe 'when the zipcode is not an integer' do
      before { address.zipcode = 'abcde' }
      it 'should require a valid zipcode' do
        expect(address).to_not be_valid
      end
    end

    describe 'when the zipcode is too short' do
      before { address.zipcode = 1111 }
      it 'should require a longer zipcode' do
        expect(address).to_not be_valid
      end
    end

    describe 'when the zipcode is too long' do
      before { address.zipcode = 111_111_1 }
      it 'should require a shorter zipcode' do
        expect(address).to_not be_valid
      end
    end

    describe 'when the country is not present' do
      before { address.country = '' }
      it 'should require a short address' do
        expect(address).to_not be_valid
      end
    end
  end
end
