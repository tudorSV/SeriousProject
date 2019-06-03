require 'rails_helper'

describe 'Shops' do
  let(:company) { FactoryBot.create(:company) }
  let(:user) { FactoryBot.create(:user, active: true) }
  let(:shop) { FactoryBot.create(:shop, company: company) }
  let(:shop2) { FactoryBot.create(:shop, company: company) }

  before do
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  describe 'index' do
    it 'should have content' do
      company
      shop
      visit company_shops_path(company)
      expect(page).to have_selector('h1', text: "All the shops that belong to the company: #{company.name}")
      expect(page).to have_content(shop.name)
      expect(page).to have_link('Create')
      expect(page).to have_link('Back to the company')
    end
  end

  describe 'create' do
    let(:new_name) { 'Shop 1' }
    let(:new_email) { 'Shop1@example.com' }
    let(:new_short_address) { 'addr 1' }
    let(:new_full_address) { 'addr full 1' }
    let(:new_city) { 'City 1' }
    let(:new_zipcode) { '12345' }
    let(:new_country) { 'Country' }
    it 'should have content' do
      user
      company
      visit new_company_shop_path(company)
      expect(page).to have_selector('h1', text: 'Create a new shop. Input information for a new shop')
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_field('Short address')
      expect(page).to have_field('Full address')
      expect(page).to have_field('City')
      expect(page).to have_field('Zipcode')
      expect(page).to have_field('Country')
      fill_in 'Name',          with: new_name
      fill_in 'Email',         with: new_email
      fill_in 'Short address', with: new_short_address
      fill_in 'Full address',  with: new_full_address
      fill_in 'City',          with: new_city
      fill_in 'Zipcode',       with: new_zipcode
      fill_in 'Country',       with: new_country
      click_button 'Create a new shop'
      expect(page).to have_selector('h2', text: "Information about #{new_name} which belongs to #{company.name}")
      expect(page).to have_selector('li', text: new_name)
      expect(page).to have_selector('li', text: new_email)
      expect(page).to have_selector('li', text: 'Active')
      expect(page).to have_selector('li', text: new_short_address)
      expect(page).to have_selector('li', text: new_full_address)
      expect(page).to have_selector('li', text: new_city)
      expect(page).to have_selector('li', text: new_zipcode)
      expect(page).to have_selector('li', text: new_country)
    end
  end

  describe 'show' do
    it 'should have content' do
      visit company_shop_path(company, shop)
      expect(page).to have_selector('h2', text: "Information about #{shop.name} which belongs to #{company.name}")
      expect(page).to have_selector('li', text: shop.name)
      expect(page).to have_selector('li', text: shop.email)
      expect(page).to have_selector('li', text: 'Active')
      expect(page).to have_selector('li', text: shop.address.short_address)
      expect(page).to have_selector('li', text: shop.address.full_address)
      expect(page).to have_selector('li', text: shop.address.city)
      expect(page).to have_selector('li', text: shop.address.zipcode)
      expect(page).to have_selector('li', text: shop.address.country)
    end
  end

  describe 'delete' do
    it 'should have content' do
      company
      shop
      shop2
      visit company_shop_path(company, shop)
      click_link('Delete shop')
      expect(page).to_not have_selector('li', text: shop.name)
      expect(page).to have_selector('li', text: shop2.name)
    end
  end

  describe 'edit' do
    let(:new_name) { 'Shop edit' }
    let(:new_email) { 'Shopedit@example.com' }
    let(:new_short_address) { 'edit' }
    let(:new_full_address) { 'edit' }
    let(:new_city) { 'City edit' }
    let(:new_zipcode) { '01234' }
    let(:new_country) { 'Country' }
    it 'should have content' do
      visit edit_company_shop_path(company, shop)
      expect(page).to have_selector('h1', text: "Edit #{shop.name}")
      fill_in 'Name',          with: new_name
      fill_in 'Email',         with: new_email
      fill_in 'Short address', with: new_short_address
      fill_in 'Full address',  with: new_full_address
      fill_in 'City',          with: new_city
      fill_in 'Zipcode',       with: new_zipcode
      fill_in 'Country',       with: new_country
      click_button 'Save changes'
      expect(page).to have_selector('h2', text:  "Information about #{new_name} which belongs to #{company.name}")
      expect(page).to have_selector('li', text:  new_name)
      expect(page).to have_selector('li', text:  new_email)
      expect(page).to have_selector('li', text:  new_short_address)
      expect(page).to have_selector('li', text:  new_full_address)
      expect(page).to have_selector('li', text:  new_city)
      expect(page).to have_selector('li', text:  new_name)
      expect(page).to have_selector('li', text:  new_zipcode)
      expect(page).to have_selector('li', text:  new_country)
    end
  end

  describe 'JSON response' do
    it 'should index from one company' do
      company
      shop
      shop2
      visit api_company_shops_path(company)
      expect(page).to have_text shop.to_json
      expect(page).to have_text shop2.to_json
    end

    it 'should index from all companies' do
      shop
      shop2
      visit api_companies_shops_path
      expect(page).to have_text shop.to_json
      expect(page).to have_text shop2.to_json
    end
  end
end
