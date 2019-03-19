require 'rails_helper'

describe "Shops" do

  let(:company) { FactoryBot.create(:company) }
  let(:shop) { FactoryBot.create(:shop, company: company) }

  describe "index" do
    it "should have content" do
      visit company_shops_path(company)
      expect(page).to have_selector('h1',   text:  'All the shops for the companies with the ID of:')
      expect(page).to have_link('Create')
      expect(page).to have_link('Back to the company' )
    end
  end

  describe "create" do
    it "should have content" do
      visit new_company_shop_path(company)
      expect(page).to have_selector('h1',   text:  'Input information for a new shop')
      expect(page).to have_field('Name')
      expect(page).to have_field('Email' )
      expect(page).to have_field('Short address')
      expect(page).to have_field('Full address')
      expect(page).to have_field('City')
      expect(page).to have_field('Zipcode')
      expect(page).to have_field('Country')
      click_button "Create a new shop"
      company_shop_path(company, shop)
    end
  end

  describe "show" do
    it "should have content" do
      visit company_shop_path(company, shop)
      expect(page).to have_selector('h1', text:  "The information for the shop with the id of #{shop.id} is:")
      expect(page).to have_selector('li', text:  shop.name)
      expect(page).to have_selector('li', text:  shop.email)
      expect(page).to have_selector('li', text:  shop.active)
      expect(page).to have_selector('li', text:  shop.address.short_address)
      expect(page).to have_selector('li', text:  shop.address.full_address)
      expect(page).to have_selector('li', text:  shop.address.city)
      expect(page).to have_selector('li', text:  shop.address.zipcode)
      expect(page).to have_selector('li', text:  shop.address.country)

    end
  end

  describe "delete" do
    it "should have content" do
      visit company_shop_path(company, shop)
      click_link "Delete shop"
      expect(company_shop_path(company, shop)).not_to have_selector('h1', text: "The information for the shop with the id of #{shop.id} is:")
    end

   describe "edit" do
     let(:new_name) { "Shop edit" }
     let(:new_email) { "Shopedit@example.com" }
     # let(:new_active) { false }
     let(:new_short_address) { "edit" }
     let(:new_full_address) { "edit" }
     let(:new_city) { "City edit" }
     let(:new_zipcode) { "01234" }
     let(:new_country) { "Country" }
     it "should have content" do
       visit edit_company_shop_path(company, shop)
       expect(page).to have_selector('h1', text: 'Edit the shop')
       fill_in "Name",          with: new_name
       fill_in "Email",         with: new_email
       # fill_in "Active",        with: new_active
       fill_in "Short address", with: new_short_address
       fill_in "Full address",  with: new_full_address
       fill_in "City",          with: new_city
       fill_in "Zipcode",       with: new_zipcode
       fill_in "Country",       with: new_country
       click_button "Update the shop"
       # visit company_shop_path(company, shop)
       expect(page).to have_selector('h1', text:  "The information for the shop with the id of #{shop.id} is")
       expect(page).to have_selector('li', text:  new_name)
       expect(page).to have_selector('li', text:  new_email)
       # expect(page).to have_selector('li', text:  new_active)
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
