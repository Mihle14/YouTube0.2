class Post < ApplicationRecord
    belongs_to :user,optional: true
    has_one_attached :image
    has_one_attached :video
    after_initialize { self.views ||= 0 }
    validates :title, presence: true
end
