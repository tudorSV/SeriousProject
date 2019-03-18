require 'rails_helper'

describe "Companies" do

 describe "index" do
     it "should have content" do
       visit companies_path
       expect(page).to have_selector('h1',   text:  'All the companies from the database')
       expect(page).to have_link('Create')
       expect(page).to have_link('Home page' )
     end
   end

  describe "create" do
      let(:company) { FactoryBot.create(:company) }
      it "should have content" do
        visit new_company_path
        expect(page).to have_selector('h1',   text: 'Sign up')
        expect(page).to have_field("Name")
        expect(page).to have_field("Email")
        click_button "Save changes"
        visit company_path(company)
      end
  end


  describe "show" do
    let(:company) { FactoryBot.create(:company) }
    it "should have content" do
      visit company_path(company)
      expect(page).to have_selector('h1', text:  "Information about the company with the ID of #{company.id}")
      expect(page).to have_selector('li', text:  company.name)
      expect(page).to have_selector('li', text:  company.email)
      expect(page).to have_selector('li', text:  company.active)
    end
  end

  describe "delete" do
    let(:company) { FactoryBot.create(:company) }
    it "should have content" do
      visit company_path(company)
      click_link "delete"
      expect(company_path(company)).not_to have_selector('h1', text: "Information about the company with the ID of #{company.id}")
    end
  end

  describe "edit" do
    let(:company) { FactoryBot.create(:company) }
    let(:new_name) { "Company 3 edit" }
    let(:new_email) { "Company_3@example.com" }
    let(:new_active) { false }
    before do
      visit edit_company_path(company)
      expect(page).to have_selector('h1', text: 'Update your companies profile')
      fill_in "Name",       with: new_name
      fill_in "Email",      with: new_email
      fill_in "Active",     with: new_active
      click_button "Save changes"
    end
    it "should have content" do
      visit company_path(company)
      # expect(page).to have_selector('h1', text:  "Information about the company with the ID of")
      expect(page).to have_selector('li', text:  new_name)
      expect(page).to have_selector('li', text:  new_email)
      expect(page).to have_selector('li', text:  new_active)
    end
    #  assert_equal '/companies/47' , current_path
  end
end
