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

  WEEK = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
          'Friday', 'Saturday'].freeze

  def week_day
    WEEK[day]
  end
end
