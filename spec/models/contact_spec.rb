require 'rails_helper'

describe 'Contact model' do
  let(:contact) { FactoryBot.create(:contact) }

  describe 'validations' do
    describe 'the object created by the factory' do
      it 'should be valid' do
        expect(contact).to be_valid
      end
    end

    describe 'when the name is not present' do
      before { contact.name = '' }
      it 'should require a name' do
        expect(contact).to_not be_valid
      end
    end

    describe 'when the name is too long' do
      before { contact.name = 'a' * 21 }
      it 'should require a shorter name' do
        expect(contact).to_not be_valid
      end
    end

    describe 'when the email is invalid' do
      before { contact.email = 'user@email,com' }
      it 'should require a valid email' do
        expect(contact).to_not be_valid
      end
    end

    describe 'when the email is not present' do
      before { contact.email = '' }
      it 'should require a valid email' do
        expect(contact).to_not be_valid
      end
    end

    describe 'when message is too long ' do
      before { contact.message = 'a' * 513 }
      it 'should be of valid length' do
        expect(contact).to_not be_valid
      end
    end
  end
end
