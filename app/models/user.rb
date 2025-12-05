class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_views, dependent: :destroy
  has_many :viewed_posts, through: :post_views, source: :post
  has_one :channel, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_channels, through: :subscriptions, source: :channel
  has_many :posts, through: :channel
  validates :email, uniqueness: { message: "has already been used before" }
  validates :name, uniqueness: { message: "has already been used before" }, allow_nil: true
  validates :surname, uniqueness: { scope: :name, message: "with this name has already been used before" }, allow_nil: true
  after_create :create_channel_for_user

  private

  def create_channel_for_user
    build_channel(name: name || "Channel #{id}").save
  end



end
