require 'rails_helper'

describe 'Contacts' do
  let(:user) { FactoryBot.create(:user, active: true) }
  let(:contact) { FactoryBot.create(:contact) }

  describe 'Json tests', type: :request do
    it 'should succesfully post 'do
      params = { contact: { name: 'test name', email: 'email@example,com',
                            phone_number: '98731274', message: 'This is a stub' } }
      post 'http://localhost:3000/api/create_contact_message'
      assert_response :success
    end
  end

  describe 'user is not logged in' do
    describe 'sending message' do
      let(:new_name) { 'New User' }
      let(:new_email) { 'NewUser@example.com' }
      let(:new_message) { 'This is a stub' }
      it 'should sent annonymous' do
        visit new_contact_message_url
        expect(page).to have_content('Name')
        expect(page).to have_content('Email')
        expect(page).to have_content('Message')
        fill_in 'Name',       with: new_name
        fill_in 'Email',      with: new_email
        fill_in 'Message',    with: new_message
        click_button 'Submit message'
        expect(page).to have_text 'The feedback has been received. Thank you!'
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

    describe 'sending message'
    let(:new_message) { 'This is a stub' }
    it 'should be sent with the current user' do
      user
      visit new_contact_message_url
      expect(page).to have_content('Name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Message')
      expect(page).to have_content('Phone number')
      fill_in 'Message', with: new_message
      click_button 'Submit message'
      expect(page).to have_text 'The feedback has been received. Thank you!'
    end
  end
end
