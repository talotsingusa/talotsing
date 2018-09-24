class SubCategory < ApplicationRecord
  has_many :product_types, dependent: :destroy
  belongs_to :category
  has_many :product_sub_categories, dependent: :destroy
  has_many :products , through: :product_sub_categories

  has_attached_file :image, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
