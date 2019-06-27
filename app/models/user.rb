class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :store
  has_one :shipping, dependent: :destroy
  has_many :user_favorites, dependent: :destroy
  has_many :products ,through: :user_favorites

  has_many :recent_views, dependent: :destroy
  has_many :products ,through: :recent_views
  has_many :orders
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
  has_many :personal_messages, dependent: :destroy
  has_many :cards
#Omniauths
  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  enum user_type: [:vendor, :admin, :customer]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.admin
    User.where(user_type:'admin').take
  end
  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end
  def full_name
    "#{first_name} #{last_name}"
  end
end
