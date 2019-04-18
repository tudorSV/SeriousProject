class Appointment < ApplicationRecord
  include AASM

  belongs_to :shop
  belongs_to :user

  aasm :column => 'status' do
    state :booked, initial: true
    state :ready_for_pickup, :finished

    event :ready_for_pickup do
      transitions from: :booked, to: :ready_for_pickup
    end

    event :finished do
      transitions from: :ready_for_pickup, to: :finished
    end
  end

  validates :date, presence: true
  validates :status, presence: true
  validates :item_number, presence: true
  validate :appointment_date
  validate :available_date

  def appointment_date
    if date.present? && date.past?
      errors.add(:appointment_date, 'cannot be in the past')
    end
  end

  def available_date
    unless date.present?
      errors.add(:available_date, 'Date is full, please choose another one')
    else
      slot = shop.shop_slots[date.wday]
      appointments = shop.appointments.where(date: date)
      total_appointments = 0
      appointments.select do |appointment|
        if appointment.date.wday == date.wday
          total_appointments += appointment.item_number
        end
      end
      total_appointments += item_number
      if total_appointments > slot.max_appointments
        errors.add(:available_date, 'Date is full, please choose another one')
      end
    end
  end
end
