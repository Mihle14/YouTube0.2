require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:user).optional }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:notifications).dependent(:destroy) }
  it { should have_many(:post_views).dependent(:destroy) }
  it { should have_many(:viewers).through(:post_views).source(:user) }

  it { should validate_presence_of(:title) }

  describe "callbacks" do
    it "sets default views on initialize" do
      post = Post.new
      expect(post.views).to eq(0)
    end
  end
end

