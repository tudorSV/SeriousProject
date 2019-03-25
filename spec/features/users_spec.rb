require 'rails_helper'

describe "Users" do
  let(:user) { FactoryBot.create(:user) }

  describe "index" do
    it "should have content" do
      visit users_path
      expect(page).to have_selector('h1',    text: 'Showing all users')
      expect(page).to have_content('No user is logged in.')
      expect(page).to have_link('Sign Up')
      expect(page).to have_link('Log In')
    end
  end

  describe "create" do
    it "should have content" do
      visit new_user_path
      expect(page).to have_selector('h1', text:'Sign up')
    end
  end

  describe "delete" do
    it "should have content" do
      visit user_path(user)
      click_link('Delete user')
      expect(user_path(user)).not_to have_selector('h2',     text: "This is your profile!")
    end
  end


  describe "show" do
    it "should have content" do
      visit user_path(user)
      expect(page).to have_selector('h2',     text: "This is your profile!")
      expect(page).to have_selector('li',     text: "Name: #{user.name}")
      expect(page).to have_selector('li',     text: "Username: #{user.username}")
      expect(page).to have_selector('li',     text: "Short address: #{user.address.short_address}")
      expect(page).to have_selector('li',     text: "Full address: #{user.address.full_address}")
      expect(page).to have_selector('li',     text: "City: #{user.address.city}")
      expect(page).to have_selector('li',     text: "Zipcode: #{user.address.zipcode}")
      expect(page).to have_selector('li',     text: "Country: #{user.address.coumtry}")
      expect(page).to have_link('Edit profile')
      expect(page).to have_link('Delete user')
      expect(page).to have_link('Back to main page')
    end
  end

end
