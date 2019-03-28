require 'rails_helper'

describe 'Companies' do
  let(:company) { FactoryBot.create(:company) }
  let(:company2) { FactoryBot.create(:company) }

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
    it 'should have content' do
      visit new_company_path
      expect(page).to have_selector('h1', text: 'Create a new company')
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      fill_in 'Name',  with: 'User 1'
      fill_in 'Email', with: 'example1@email.com'
      click_button 'Save changes'
      expect(page).to have_selector('h1', text:  'Information about the current company')
      expect(page).to have_selector('li', text:  'User 1')
      expect(page).to have_selector('li', text:  'example1@email.com')
      expect(page).to have_selector('li', text:  company.active)
    end
  end

  describe 'show' do
    it 'should have content' do
      visit company_path(company)
      expect(page).to have_selector('h1', text:  'Information about the current company')
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
      expect(page).to have_selector('h1', text: 'Update your companies profile')
      fill_in 'Name',       with: new_name
      fill_in 'Email',      with: new_email
      fill_in 'Active',     with: new_active
      click_button 'Save changes'
    end
    it 'should have content' do
      visit company_path(company)
      expect(page).to have_selector('li', text:  new_name)
      expect(page).to have_selector('li', text:  new_email)
    end
  end
end
