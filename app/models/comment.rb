class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  after_create_commit { broadcast_append_to [post, :comments], target: "comments" }
  after_destroy_commit { broadcast_remove_to [post, :comments] }

end
