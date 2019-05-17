class Note < ApplicationRecord
  belongs_to :appointment

  validates :message, presence: true, length: { maximum: 512 }
end
