class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_views, dependent: :destroy
  has_many :viewed_posts, through: :post_views, source: :post


end
