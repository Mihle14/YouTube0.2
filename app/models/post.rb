class Post < ApplicationRecord
    belongs_to :user,optional: true
    belongs_to :channel
    has_one_attached :image
    has_one_attached :video
    has_one_attached :thumbnail
    has_many :notifications, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :post_views, dependent: :destroy
    has_many :viewers, through: :post_views, source: :user
    scope :search, ->(query) {
        where("title ILIKE :q OR description ILIKE :q", q: "%#{query}%")
    }

    after_initialize { self.views ||= 0 }
    validates :title, presence: true
end

