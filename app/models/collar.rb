class Collar < ApplicationRecord
  has_many :product_collars
  has_many :products , through: :product_collars
end
