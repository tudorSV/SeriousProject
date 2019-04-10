class Appointment < ApplicationRecord
  belongs_to :shop
  belongs_to :user

  validates :date, presence: true
  validate :appointment_date
  validate :available_date
  validates :item_number, presence: true
  validates :status, presence: true

  def appointment_date
    if date.present? && date.past?
      errors.add(:appointment_date, "cannot be in the past")
    end
  end

  def available_date
    shop = self.shop
    slot = shop.shop_slots[self.date.wday]
    appointments = shop.appointments.where(date: self.date)
    total_appointments = 0
    appointments.select { |appoint|
                          if appoint.date.wday == self.date.wday
                            total_appointments += appoint.item_number
                          end
                        }
    total_appointments+= item_number
    if total_appointments > slot.max_appointments
      errors.add(:available_date, 'Date is full, please choose another one')
    end
  end
end
