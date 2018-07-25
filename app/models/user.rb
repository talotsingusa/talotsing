class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :store
  has_one :shipping, dependent: :destroy
  has_many :user_favorites, dependent: :destroy
  has_many :products ,through: :user_favorites

  has_many :recent_views, dependent: :destroy
  has_many :products ,through: :recent_views
  has_many :orders
  def full_name
    "#{first_name} #{last_name}"
  end

  def user_type

  end
end
