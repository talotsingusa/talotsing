class Craft < ApplicationRecord
  has_many :product_crafts
  has_many :products , through: :product_crafts
end
