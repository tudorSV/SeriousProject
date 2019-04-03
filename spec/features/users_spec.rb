require 'rails_helper'

describe 'Users' do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }

  describe 'user is not logged in' do
    describe 'index' do
      it 'should have content' do
        visit users_path
        expect(page).to have_content('Access Denied')
      end
    end

    describe 'show' do
      it 'should have content' do
        visit user_path(user)
        expect(page).to have_content('Access Denied')
      end
    end

    describe 'edit' do
      it 'should have content' do
        visit edit_user_path(user)
        expect(page).to have_content('Access Denied')
      end
    end

    describe 'create' do
      let(:new_username) { 'New Username' }
      let(:new_name) { 'New User' }
      let(:new_email) { 'NewUser@example.com' }
      let(:password) { 'newpassword' }
      let(:new_short_address) { 'Addr1' }
      let(:new_full_address) { 'Faddr1' }
      let(:new_city) { 'city' }
      let(:new_zipcode) { '71234' }
      let(:new_country) { 'New Country' }
      it 'should have content' do
        visit new_user_path
        expect(page).to have_selector('h1', text: 'Sign up')
        expect(page).to have_field('Username')
        expect(page).to have_field('Name')
        expect(page).to have_field('Password')
        expect(page).to have_field('Password confirmation')
        expect(page).to have_field('Email')
        expect(page).to have_field('Short address')
        expect(page).to have_field('Full address')
        expect(page).to have_field('City')
        expect(page).to have_field('Zipcode')
        expect(page).to have_field('Country')
        fill_in 'Username',               with: new_username
        fill_in 'Name',                   with: new_name
        fill_in 'Password',               with: password
        fill_in 'Password confirmation',  with: password
        fill_in 'Email',                  with: new_email
        fill_in 'Short address',          with: new_short_address
        fill_in 'Full address',           with: new_full_address
        fill_in 'City',                   with: new_city
        fill_in 'Zipcode',                with: new_zipcode
        fill_in 'Country',                with: new_country
        click_button 'Sign up'
        visit new_session_path
        fill_in 'Username', with: new_username
        fill_in 'Password', with: password
        click_button 'Login'
        click_link new_name
        expect(page).to have_selector('h2', text: 'This is your profile!')
        expect(page).to have_selector('li', text: "Name: #{new_name}")
        expect(page).to have_selector('li', text: "Email: #{new_email}")
        expect(page).to have_selector('li', text: "Username: #{new_username}")
        expect(page).to have_selector('li', text: 'Is admin? true')
        expect(page).to have_selector('li', text: "Short address: #{new_short_address}")
        expect(page).to have_selector('li', text: "Full address: #{new_full_address}")
        expect(page).to have_selector('li', text: "City: #{new_city}")
        expect(page).to have_selector('li', text: "Zipcode: #{new_zipcode}")
        expect(page).to have_selector('li', text: "Country: #{new_country}")
      end
    end
  end

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
        expect(page).to have_selector('li', text: user.name)
        expect(page).to have_content("Logged in as #{user.email}.")
        expect(page).to have_link('Log Out', href: logout_path)
      end
    end

    describe 'create' do
      it 'should have content' do
        visit new_user_path
        expect(page).to have_selector('h2', text: 'This is your profile')
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
        expect(page).to have_link('Back to users page')
      end
    end

    describe 'delete' do
      it 'should have content' do
        visit user_path(user2)
        click_link('Delete user')
        expect(page).to have_selector('h1', text: 'Showing all users')
        expect(page).to have_selector('li', text: user.name)
        expect(page).to_not have_selector('li', text: user2.name)
      end
    end

    describe 'edit' do
      let(:new_name) { 'User edit' }
      let(:new_email) { 'Useredit@example.com' }
      let(:new_username) { 'Username edit' }
      let(:password) { 'password' }
      let(:new_short_address) { 'edit' }
      let(:new_full_address) { 'edit' }
      let(:new_city) { 'City edit' }
      let(:new_zipcode) { '01234' }
      let(:new_country) { 'Country' }
      it 'should have content' do
        visit edit_user_path(user)
        expect(page).to have_selector('h2', text: 'Edit your profile!')
        fill_in 'Name',                  with: new_name
        fill_in 'Email',                 with: new_email
        fill_in 'Username',              with: new_username
        fill_in 'Password',              with: password
        fill_in 'Password confirmation', with: password
        fill_in 'Short address',         with: new_short_address
        fill_in 'Full address',          with: new_full_address
        fill_in 'City',                  with: new_city
        fill_in 'Zipcode',               with: new_zipcode
        fill_in 'Country',               with: new_country
        click_button 'Save profile'
        expect(page).to have_selector('h2', text:  'This is your profile!')
        expect(page).to have_selector('li', text:  new_name)
        expect(page).to have_selector('li', text:  new_email)
        expect(page).to have_selector('li', text:  new_username)
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
