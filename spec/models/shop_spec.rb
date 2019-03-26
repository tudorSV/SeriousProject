require 'rails_helper'

describe 'Shop model' do
  let(:shop) { FactoryBot.create(:shop) }

  describe 'when the name is not present' do
    before { shop.name = '' }
    it 'should require a name' do
      expect(shop).to_not be_valid
    end
  end

  describe 'when the name is too long' do
    before { shop.name = 'a' * 21 }
    it 'should require a shorter name' do
      expect(shop).to_not be_valid
    end
  end

  describe 'when the email is invalid' do
    before { shop.email = 'company@email,com' }
    it 'should require a valid email' do
      expect(shop).to_not be_valid
    end
  end

  describe 'when the email is not present' do
    before { shop.email = '' }
    it 'should require a valid email' do
      expect(shop).to_not be_valid
    end
  end

  describe 'when the email is already taken' do
    before do
      @shop_with_same_email = shop.dup
      @shop_with_same_email.email = shop.email.upcase
      @shop_with_same_email.save
    end
    it 'should have a unique email' do
      expect(@shop_with_same_email).to_not be_valid
    end
  end
end
