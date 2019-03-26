require 'rails_helper'
require 'pry'

describe 'Shops' do
  let(:company) { FactoryBot.create(:company) }
  let(:shop) { FactoryBot.create(:shop, company: company) }

  describe 'index' do
    it 'should have content' do
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
    let(:shop2) { FactoryBot.create(:shop) }
    it 'should have content' do
      company
      visit new_company_shop_path(company)
      expect(page).to have_selector('h1', text: 'Input information for a new shop')
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
      expect(page).to have_selector('h1', text: 'The information for the shop:')
      expect(page).to have_selector('li', text: new_name)
      expect(page).to have_selector('li', text: new_email)
      expect(page).to have_selector('li', text: shop.active)
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
      expect(page).to have_selector('h1', text: 'The information for the shop:')
      expect(page).to have_selector('li', text: shop.name)
      expect(page).to have_selector('li', text: shop.email)
      expect(page).to have_selector('li', text: shop.active)
      expect(page).to have_selector('li', text: shop.address.short_address)
      expect(page).to have_selector('li', text: shop.address.full_address)
      expect(page).to have_selector('li', text: shop.address.city)
      expect(page).to have_selector('li', text: shop.address.zipcode)
      expect(page).to have_selector('li', text: shop.address.country)
    end
  end

  describe 'delete', js: true do
    it 'should have content' do
      visit company_shop_path(company, shop)
      click_link('Delete shop')
      page.accept_alert
      # binding.pry
      # expect(delete_link['data-confirm']).to eq 'Are you sure you want to delete the shop?'
      # expect { click_link 'Delete shop' }.to change(Shop, :count).by(-1)
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
        click_button 'Update the shop'
        expect(page).to have_selector('h1', text:  'The information for the shop:')
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
  end
end
