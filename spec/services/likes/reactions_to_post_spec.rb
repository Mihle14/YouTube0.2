require 'rails_helper'

RSpec.describe Likes::ReactionsToPost do
  let(:post) { create(:post) }
  let(:user) { create(:user) }

  it "creates a like" do
    expect {
      described_class.new(
        post: post,
        user: user,
        like_type: "like"
      ).call
    }.to change { post.likes.count }.by(1)
  end

  it "updates like type if already liked" do
    create(:like, post: post, user: user, like_type: "like")

    described_class.new(
      post: post,
      user: user,
      like_type: "dislike"
    ).call

    expect(post.likes.first.like_type).to eq("dislike")
  end
end
