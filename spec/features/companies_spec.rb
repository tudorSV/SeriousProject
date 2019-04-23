require 'rails_helper'

describe 'Companies' do
  let(:user) { FactoryBot.create(:user, active: true) }
  let(:company) { FactoryBot.create(:company) }
  let(:company2) { FactoryBot.create(:company) }

  before do
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  describe 'index' do
    it 'should have content' do
      company
      visit companies_path
      expect(page).to have_selector('h1', text: 'All the registered companies')
      expect(page).to have_link(company.name)
      expect(page).to have_link('Create')
    end
  end

  describe 'create' do
    let(:new_name) { 'Company 3 edit' }
    let(:new_email) { 'Company_3@example.com' }
    it 'should have content' do
      visit new_company_path
      expect(page).to have_selector('h1', text: 'Create a new company')
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      fill_in 'Name',  with: new_name
      fill_in 'Email', with: new_email
      click_button 'Create a new company'
      expect(page).to have_selector('h2', text:  "Information about #{new_name}")
      expect(page).to have_selector('li', text:  new_name)
      expect(page).to have_selector('li', text:  new_email)
      expect(page).to have_selector('li', text:  'Active')
    end
  end

  describe 'show' do
    it 'should have content' do
      visit company_path(company)
      expect(page).to have_selector('h2', text:  "Information about #{company.name}")
      expect(page).to have_selector('li', text:  company.name)
      expect(page).to have_selector('li', text:  company.email)
    end
  end

  describe 'delete' do
    it 'should have content' do
      company
      company2
      visit company_path(company)
      click_link('Delete')
      expect(page).to_not have_selector('li', text: company.name)
      expect(page).to have_selector('li', text: company2.name)
    end
  end

  describe 'edit' do
    let(:new_name) { 'Company 3 edit' }
    let(:new_email) { 'Company_3@example.com' }
    let(:new_active) { false }
    before do
      visit edit_company_path(company)
      expect(page).to have_selector('h2', text: 'Update your company profile')
      fill_in 'Name',       with: new_name
      fill_in 'Email',      with: new_email
      page.uncheck('Active')
      click_button 'Save changes'
    end
    it 'should have content' do
      visit company_path(company)
      expect(page).to have_selector('li', text:  new_name)
      expect(page).to have_selector('li', text:  new_email)
      expect(page).to have_selector('li', text:  'Inactive')
    end
  end
end
