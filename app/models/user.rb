class User < ApplicationRecord
  has_many :projects, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :projects
  # Others available are :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[twitter]
end
