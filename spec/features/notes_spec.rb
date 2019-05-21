require 'rails_helper'

describe 'Notes' do
  let(:user) { FactoryBot.create(:user, active: true) }
  let(:shop) { FactoryBot.create(:shop_with_shop_slots) }
  let(:appointment) { FactoryBot.create(:appointment, shop: shop, user: user) }
  let(:note) { FactoryBot.create(:note, appointment: appointment) }

  before do
    shop
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  describe 'create', js: true do
    let(:new_message) { "Test message" }
    it 'should have content' do
      user
      shop
      appointment
      visit user_appointment_path(user, appointment)
      click_link('Add a note')
      expect(page).to have_text("Message")
      fill_in 'Message', with: new_message
      click_button('Add appointment note')
      expect(page).to have_text(new_message)
    end
  end
end
