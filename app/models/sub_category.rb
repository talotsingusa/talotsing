class SubCategory < ApplicationRecord
  has_one :product_type
  belongs_to :category
  has_one :product_sub_category
  has_one :product , through: :product_sub_category

  has_attached_file :image, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
