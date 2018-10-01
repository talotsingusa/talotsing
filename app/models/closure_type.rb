class ClosureType < ApplicationRecord
  has_many :product_closure_types
  has_many :products , through: :product_closure_types
end
