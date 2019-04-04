class Appointment < ApplicationRecord
  has_many :shops, inverse_of: :user_appointments
  has_many :users, inverse_of: :user_appointments

  validates :date, presence: true
  validates :item_number, presence: true
  validates :status, presence: true
end
