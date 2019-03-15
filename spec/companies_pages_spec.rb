require 'spec_helper'

describe "CompaniesPages" do

  describe "index" do
    it "should have content" do
      visit companies_path
      expect(page).to have_selector('h1',   'All the companies from the database')
      expect(page).to have_link('Create')
      expect(page).to have_link('Home page' )
    end
  end
end
