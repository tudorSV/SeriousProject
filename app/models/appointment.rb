class Appointment < ApplicationRecord
  belongs_to :shop
  belongs_to :user

  validates :date, presence: true
  validate :appointment_date
  validates :item_number, presence: true
  validates :status, presence: true

  def appointment_date
    if date.present? && date.past?
      errors.add(:appointment_date, "cannot be in the past")
    end
  end

  def available_appointments
    Appointments.where(shop_id, date.wday).sum(:item_number)
  end
end
