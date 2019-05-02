require 'rails_helper'

describe 'Appointments' do
  let(:user) { FactoryBot.create(:user, active: true) }
  let(:shop) { FactoryBot.create(:shop_with_shop_slots) }
  let(:appointment) { FactoryBot.create(:appointment, shop: shop, user: user) }

  before do
    shop
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  describe 'create' do
    let(:new_date) { Time.zone.now + 8.years }
    let(:new_item_number) { 2 }
    it 'should have content' do
      user
      shop
      visit new_user_appointment_path(user)
      expect(page).to have_selector('h1', text: 'Create a new appointment')
      expect(page).to have_field('Item number')
      fill_in 'Choose a date', with: new_date
      fill_in 'Item number', with: new_item_number
      click_button 'Add a new appointment'
      expect(page).to have_selector('h3', text: 'User appointments:')
      expect(page).to have_selector('li', text: "About appointment from #{new_date.strftime("%Y-%m-%d")}, containing #{new_item_number} items, with status of #{appointment.status}")
    end
  end

  describe 'edit' do
    let(:edit_date) { Date.today + 15 }
    let(:edit_number_of_items) { 2 }
    it 'should have content' do
      shop
      user
      appointment
      visit edit_user_appointment_path(user, appointment)
      expect(page).to have_selector('h1', text: 'Edit the appointment')
      expect(page).to have_field('Change the appointment date:')
      fill_in 'Change the appointment date:', with: edit_date
      fill_in 'Change the number of items:', with: edit_number_of_items
      click_button 'Edit the appointment'
      expect(page).to have_selector('h2', text: 'Appointment information:')
      expect(page).to have_selector('li', text: 'Date')
    end
  end

  describe 'show' do
    it 'should have content' do
      user
      appointment
      visit user_appointment_path(user, appointment)
      expect(page).to have_selector('h2', text: 'Appointment information:')
      expect(page).to have_selector('li', text: "Date: #{appointment.date}, total items #{appointment.item_number}")
      expect(page).to have_selector('li', text: "Status of the appointment: #{appointment.status}")
      expect(page).to have_link('Edit the appointment')
      expect(page).to have_link('Back to the user')
    end
  end

  describe 'index appointment' do
    it 'should have content' do
      user
      shop
      appointment
      visit company_shop_index_appointment_path(shop.company, shop)
      expect(page).to have_selector('h2', text: "All the appointments that belong to #{shop.name}")
      expect(page).to have_selector('li', text: "Appointment from #{appointment.date}")
      click_link 'Change to Ready for pickup'
      expect(page).to have_selector('li', text: 'Ready for pickup')
    end
  end
end
