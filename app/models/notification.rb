class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :message, presence: true
  scope :unread, -> { where(read: false) }
end
