require 'rails_helper'

describe 'Company model' do
  let(:company) { FactoryBot.create(:company) }
  let(:company2) { FactoryBot.create(:company) }

  describe 'associations' do
    describe 'shop' do
      assoc = Company.reflect_on_association(:shops).macro
      subject { assoc }
      it 'should have_many' do
        expect(subject).to eq(:has_many)
      end
    end
  end

  describe 'validations' do
    describe 'when the name is not present' do
      before { company.name = '' }
      it 'should require a name' do
        expect(company).to_not be_valid
      end
    end

    describe 'when the name is too long' do
      before { company.name = 'a' * 21 }
      it 'should require a shorter name' do
        expect(company).to_not be_valid
      end
    end

    describe 'when the name has already been taken' do
      it 'should have a unique name' do
        company2.name = company.name
        expect(company2).to_not be_valid
      end
    end

    describe 'when the email is invalid' do
      before { company.email = 'company@email,com' }
      it 'should require a valid email' do
        expect(company).to_not be_valid
      end
    end

    describe 'when the email is not present' do
      before { company.email = '' }
      it 'should require a valid email' do
        expect(company).to_not be_valid
      end
    end

    describe 'when the email is already taken' do
      it 'should have a unique email' do
        company2.email = company.email.upcase
        expect(company2).to_not be_valid
      end
    end
  end
end
