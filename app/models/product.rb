class Product < ApplicationRecord
  self.per_page = 10
  belongs_to :store

  has_many :product_colors, dependent: :destroy
  has_many :colors ,through: :product_colors

  has_many :product_sizes, dependent: :destroy
  has_many :sizes ,through: :product_sizes

  has_many :product_collars, dependent: :destroy
  has_many :collars ,through: :product_collars

  has_many :product_closure_types, dependent: :destroy
  has_many :closure_types ,through: :product_closure_types

  has_many :product_crafts, dependent: :destroy
  has_many :crafts ,through: :product_crafts

  has_many :product_designs, dependent: :destroy
  has_many :designs ,through: :product_designs

  has_many :product_design_types, dependent: :destroy
  has_many :design_types ,through: :product_design_types

  has_many :product_pattern_styles, dependent: :destroy
  has_many :pattern_styles ,through: :product_pattern_styles

  has_many :product_sleeve_types, dependent: :destroy
  has_many :sleeve_types ,through: :product_sleeve_types

  has_many :product_styles, dependent: :destroy
  has_many :styles ,through: :product_styles

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

  has_many :product_color_images, dependent: :destroy
  accepts_nested_attributes_for :product_color_images,:reject_if => lambda { |a| a[:color].blank? }, :allow_destroy => true

  has_many :order_items

  def self.search(params, current_user)
    products = where(store_id: current_user.store.id)
    puts products
    products = products.where("name like ?", "%#{params[:search]}%") if params[:search]
    products
  end

  def multiply_price
    if self.price < 10 then self.price *= 2 else self.price += 10 end
    self.price.round(2)
  end

end
