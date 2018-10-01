class DesignType < ApplicationRecord
  has_many :product_design_types
  has_many :products , through: :product_design_types
end
