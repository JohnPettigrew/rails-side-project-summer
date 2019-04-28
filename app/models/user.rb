class User < ApplicationRecord
  has_many :projects, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :projects
  # Others available are :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[twitter]

  def self.from_omniauth(auth)
    user.twitter_user_url = auth.info.image # assuming the user model has an image
  end

  def twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.TWITTER_API_KEY
      config.consumer_secret     = Rails.application.credentials.TWITTER_API_SECRET
      config.access_token        = self.twitter_key
      config.access_token_secret = self.twitter_secret
    end
  end
end
