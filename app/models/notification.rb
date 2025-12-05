class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :notification_type, presence: true
  scope :unread, -> { where(read: false) }

end
