class PatternStyle < ApplicationRecord
  has_many :product_pattern_styles
  has_many :products , through: :product_pattern_styles
end
