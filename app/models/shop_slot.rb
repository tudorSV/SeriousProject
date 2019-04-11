class ShopSlot < ApplicationRecord
  belongs_to :shop
  belongs_to :company

  delegate :company, to: :shop

  validates :day, presence: true,
                  uniqueness: { scope: :shop_id }
  validates :max_appointments, presence: true,
                               numericality: { less_than_or_equal_to: 10 }

  validates :open, presence: true
  validates :close, presence: true
  validates :closed, presence: true

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
