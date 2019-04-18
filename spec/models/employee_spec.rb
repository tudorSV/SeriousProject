require 'rails_helper'

describe 'Employee model' do
  let(:employee) { FactoryBot.create(:employee) }
  let(:employee2) { FactoryBot.create(:employee) }

  describe 'associations' do
    describe 'user' do
      assoc = Employee.reflect_on_association(:user).macro
      subject { assoc }
      it 'should belong_to' do
        expect(subject).to eq(:belongs_to)
      end
    end

    describe 'shop' do
      assoc = Employee.reflect_on_association(:shop).macro
      subject { assoc }
      it 'should belong_to' do
        expect(subject).to eq(:belongs_to)
      end
    end

    describe 'company' do
      assoc = Employee.reflect_on_association(:company).macro
      subject { assoc }
      it 'should belong_to' do
        expect(subject).to eq(:belongs_to)
      end
    end
  end

  describe 'validations' do
    describe 'when the user ID is not unique' do
      before { employee2.user_id = employee.user_id }
      it 'should be unique' do
        expect(employee2).to_not be_valid
      end
    end

    describe 'when a role is not present' do
      before { employee.role = '' }
      it 'should be present' do
        expect(employee).to_not be_valid
      end
    end
  end
end
