class Post < ApplicationRecord
    belongs_to :user,optional: true
    has_one_attached :image
    after_initialize { self.views ||= 0 }
    validates :title, presence: true
end
