class Address < ApplicationRecord
  has_one :shops, inverse_of: :address
end
