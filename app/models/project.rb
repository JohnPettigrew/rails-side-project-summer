class Project < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 1500 }
end
