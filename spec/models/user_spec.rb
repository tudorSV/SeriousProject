require 'rails_helper'

describe 'User model' do
  let(:user) { FactoryBot.create(:user) }

  describe 'associations' do
    describe 'address' do
      assoc = User.reflect_on_association(:address).macro
      subject { assoc }
      it 'should belong_to' do
        expect(subject).to eq(:belongs_to)
      end
    end
  end

  describe 'validations' do
    describe 'when the name is not present' do
      before { user.name = '' }
      it 'should require a name' do
        expect(user).to_not be_valid
      end
    end

    describe 'when the name is too long' do
      before { user.name = 'a' * 21 }
      it 'should require a shorter name' do
        expect(user).to_not be_valid
      end
    end

    describe 'when the username is too long' do
      before { user.username = '' }
      it 'should require a shorter name' do
        expect(user).to_not be_valid
      end
    end

    describe 'when the username is too long' do
      before { user.username = 'a' * 21 }
      it 'should require a shorter name' do
        expect(user).to_not be_valid
      end
    end

    describe 'when password is not present' do
      before { user.password_digest = '' }
      it 'should require a password' do
        expect(user).to_not be_valid
      end
    end

    describe 'when password is too short' do
      before { user.password = 'a' * 5 }
      it 'should require a longer password' do
        expect(user).to_not be_valid
      end
    end

    describe 'when the email is invalid' do
      before { user.email = 'user@email,com' }
      it 'should require a valid email' do
        expect(user).to_not be_valid
      end
    end

    describe 'when the email is not present' do
      before { user.email = '' }
      it 'should require a valid email' do
        expect(user).to_not be_valid
      end
    end
  end
end
