require 'rails_helper'

describe 'Users' do
  let(:user) { FactoryBot.create(:user) }

  describe 'user is logged in' do
    before do
      visit new_session_path
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Login'
    end

    describe 'index' do
      it 'should have content' do
        visit users_path
        expect(page).to have_selector('h1', text: 'Showing all users')
        expect(page).to have_content("Logged in as #{user.email}.")
        expect(page).to have_link('Log out')
      end
    end

    describe 'create' do
      it 'should have content' do
        visit new_user_path
        expect(page).to have_selector('h1', text: 'Sign up')
      end
    end

    describe 'delete' do
      it 'should have content' do
        visit user_path(user)
        click_link('Delete user')
        expect(user_path(user)).not_to have_selector('h2', text: 'This is your profile!')
      end
    end

    describe 'show' do
      it 'should have content' do
        visit user_path(user)
        expect(page).to have_selector('h2', text: 'This is your profile!')
        expect(page).to have_selector('li', text: "Name: #{user.name}")
        expect(page).to have_selector('li', text: "Email: #{user.email}")
        expect(page).to have_selector('li', text: "Username: #{user.username}")
        expect(page).to have_selector('li', text: "Is admin? #{user.admin}")
        expect(page).to have_selector('li', text: "Short address: #{user.address.short_address}")
        expect(page).to have_selector('li', text: "Full address: #{user.address.full_address}")
        expect(page).to have_selector('li', text: "City: #{user.address.city}")
        expect(page).to have_selector('li', text: "Zipcode: #{user.address.zipcode}")
        expect(page).to have_selector('li', text: "Country: #{user.address.country}")
        expect(page).to have_link('Edit profile')
        expect(page).to have_link('Delete user')
        expect(page).to have_link('Back to main page')
      end
    end
  end
end
