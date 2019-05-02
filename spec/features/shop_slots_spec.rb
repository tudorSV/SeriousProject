require 'rails_helper'

describe 'Shop Slots' do
  let(:company) { FactoryBot.create(:company) }
  let(:shop) { FactoryBot.create(:shop, company: company) }
  let(:user) { FactoryBot.create(:user, active: true) }
  let(:shop_slot) { FactoryBot.create(:shop_slot) }

  before do
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  describe 'create' do
    let(:max_appointments) { 8 }
    it 'should have content' do
      company
      shop
      visit new_company_shop_shop_slot_path(company, shop)
      expect(page).to have_selector('h1', text: 'Input info about the shop appointment data:')
      expect(page).to have_field('Max appointments')
      fill_in 'Max appointments', with: max_appointments
      click_button 'Add appointment data to the shop'
      expect(page).to have_selector('h2', text: 'Working hours and avalilable slots:')
      expect(page).to have_link('Edit Sunday slot')
    end
  end

  describe 'edit' do
    let(:edit_max_appointmnets) { 9 }
    it 'should have content' do
      shop_slot
      visit edit_company_shop_shop_slot_path(shop_slot.shop.company, shop_slot.shop, shop_slot)
      expect(page).to have_selector('h1', text: 'Change the shop slot')
      fill_in "Max appointments", with: edit_max_appointmnets
      click_button 'Change shop slot'
      expect(page).to have_selector('h2', text: 'Working hours and avalilable slots:')
      expect(page).to have_selector('li', text: "#{shop_slot.week_day.humanize} working hours:")
    end
  end
end
