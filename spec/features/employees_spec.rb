require 'rails_helper'

describe 'Employees' do
  let(:company) { FactoryBot.create(:company) }
  let(:shop) { FactoryBot.create(:shop, company: company) }
  let(:user) { FactoryBot.create(:user) }
  let(:employee) { FactoryBot.create(:employee, shop: shop, company: company) }
  let(:employee2) { FactoryBot.create(:employee, shop: shop, company: company) }

  before do
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  describe 'index' do
    it 'should have content' do
      employee
      visit company_shop_employees_path(company, shop)
      expect(page).to have_selector('h1', text: "All employees that belong to shop: #{shop.name}")
      expect(page).to have_content(employee.user.name)
      expect(page).to have_link('Back to the shops')
    end
  end

  describe 'create' do
    let(:new_role) { 'New Role' }
    it 'should have content' do
      company
      shop
      visit new_company_shop_employee_path(company, shop)
      expect(page).to have_selector('h1', text: 'Input info about the new employee')
      expect(page).to have_field('Role')
      expect(page).to have_field('User')
      fill_in 'Role', with: new_role
      click_button 'Add employee'
      expect(page).to have_selector('h2', text: "Information about #{user.name}")
      expect(page).to have_selector('li', text: "Belongs to company #{company.name}, shop #{shop.name}")
      expect(page).to have_selector('li', text: "Has the position of #{new_role}")
    end
  end

  describe 'edit' do
    let(:new_role) { 'New Role' }
    it 'should have content' do
      visit edit_company_shop_employee_path(company, shop, employee)
      expect(page).to have_selector('h1', text: 'Change the employees job')
      fill_in 'Role', with: new_role
      click_button 'Update employee'
      expect(page).to have_selector('h2', text: "Information about #{employee.user.name}")
      expect(page).to have_selector('li', text: "Belongs to company #{company.name}, shop #{shop.name}")
      expect(page).to have_selector('li', text: "Has the position of #{new_role}")
    end
  end

  describe 'show' do
    it 'should have content' do
      visit company_shop_employee_path(company, shop, employee)
      expect(page).to have_selector('h2', text: "Information about #{employee.user.name}")
      expect(page).to have_selector('li', text: "Belongs to company #{company.name}, shop #{shop.name}")
      expect(page).to have_selector('li', text: "Has the position of #{employee.role}")
      expect(page).to have_link('Edit the employee role')
      expect(page).to have_link('Delete the employee')
      expect(page).to have_link('Show all employees')
      expect(page).to have_link('Back')
    end
  end

  describe 'delete' do
    it 'should have content' do
      employee
      employee2
      visit company_shop_employee_path(company, shop, employee)
      click_link('Delete the employee')
      expect(page).to_not have_selector('li', text: employee.user.name)
      expect(page).to have_selector('li', text: employee2.user.name)
    end
  end
end
