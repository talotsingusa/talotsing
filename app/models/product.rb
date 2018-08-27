class Product < ApplicationRecord
  belongs_to :store

  has_many :product_colors, dependent: :destroy
  has_many :colors ,through: :product_colors

  has_many :product_sizes, dependent: :destroy
  has_many :sizes ,through: :product_sizes

  has_one :product_brand, dependent: :destroy
  has_one :brand ,through: :product_brand

  has_one :product_category, dependent: :destroy
  has_one :category ,through: :product_category

  has_one :product_sub_category, dependent: :destroy
  has_one :sub_category ,through: :product_sub_category

  has_one :product_group, dependent: :destroy
  has_one :product_type ,through: :product_group

  has_many :user_favorites, dependent: :destroy
  has_many :users ,through: :user_favorites

  has_many :recent_views, dependent: :destroy
  has_many :users ,through: :recent_views

  has_many :product_images, dependent: :destroy

  has_many :product_shipments, dependent: :destroy
  accepts_nested_attributes_for :product_shipments,:reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  has_many :product_specifications, dependent: :destroy
  accepts_nested_attributes_for :product_specifications,:reject_if => lambda { |a| a[:spec_key].blank? }, :allow_destroy => true

  has_many :order_items
end
