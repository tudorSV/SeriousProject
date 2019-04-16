class ShopSlot < ApplicationRecord
  belongs_to :shop
  delegate :company, to: :shop

  validates :day, presence: true,
                  uniqueness: { scope: :shop_id },
                  numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 6}
  validates :max_appointments, presence: true,
                               numericality: { less_than_or_equal_to: 50 }

  validates :open_hour, presence: true
  validates :close_hour, presence: true

  def week_day
    case day
    when 0
      'Sunday'
    when 1
      'Monday'
    when 2
      'Tuesday'
    when 3
      'Wednesday'
    when 4
      'Thursday'
    when 5
      'Friday'
    when 6
      'Saturday'
    end
  end
end
