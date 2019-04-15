require 'rails_helper'

describe 'Appointments' do
  let(:user) { FactoryBot.create(:user) }
  let(:shop) { FactoryBot.create(:shop) }
  let(:shop_slot1) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot2) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot3) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot4) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot5) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot6) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:shop_slot7) { FactoryBot.create(:shop_slot, shop: shop) }
  let(:appointment) { FactoryBot.create(:appointment, shop: shop, user: user) }

  before do
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'
    shop_slot1
    shop_slot2
    shop_slot3
    shop_slot4
    shop_slot5
    shop_slot6
    shop_slot7
  end

  describe 'create' do
    let(:new_date) { '2019-04-21' }
    let(:new_item_number) { 4 }
    it 'should have content' do
      user
      appointment
      visit new_user_appointment_path(user)
      expect(page).to have_selector('h1', text: 'Create a new appointment')
      expect(page).to have_field('Item number')
      fill_in 'Choose a date', with: new_date
      fill_in 'Item number', with: new_item_number
      click_button 'Add a new appointment'
      expect(page).to have_selector('h3', text: 'User appointments:')
      expect(page).to have_selector('li', text: "About appointment from #{new_date}, containing #{new_item_number} items, with status of #{appointment.status}")
    end
  end

  describe 'edit' do
    let(:edit_date) { Date.today + 15 }
    let(:edit_number_of_items) { 2 }
    it 'should have content' do
      user
      appointment
      visit edit_user_appointment_path(appointment.user, appointment)
      expect(page).to have_selector('h1', text: 'Edit the appointment')
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
end
