class ShopSlot < ApplicationRecord
  belongs_to :shop
  belongs_to :company

  validates :day, presence: true,
                  numericality: { only_integer: true, less_than_or_equal_to: 7 }
  validates :max_appointments, presence: true,
                               numericality: { less_than_or_equal_to: 0 }
  validates :open, presence: true
  validates :close, presence: true
  validates :closed, presence: true
end
