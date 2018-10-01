class Design < ApplicationRecord
  has_many :product_designs
  has_many :products , through: :product_designs
end
