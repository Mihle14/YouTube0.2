class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true
  after_create_commit { Comments::Broadcast.created(self) }
  after_destroy_commit { Comments::Broadcast.deleted(self) }

end
