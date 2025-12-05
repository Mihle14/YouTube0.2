class Channel < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  has_one_attached :avatar
  has_one_attached :banner
end
