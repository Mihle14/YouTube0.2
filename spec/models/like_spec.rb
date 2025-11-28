require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }

  describe "uniqueness validation" do
    it "prevents duplicate likes for the same user, post, and like_type" do
      user = create(:user)
      post_record = create(:post)

      create(:like, user: user, post: post_record, like_type: "upvote")

      duplicate = build(:like, user: user, post: post_record, like_type: "upvote")
      expect(duplicate.valid?).to be_falsey
      expect(duplicate.errors[:user_id]).to include("has already liked/disliked this post")
    end

    it "allows different like_type on different posts" do
      user = create(:user)
      post1 = create(:post)
      post2 = create(:post)

      create(:like, user: user, post: post1, like_type: "upvote")

      new_like = build(:like, user: user, post: post2, like_type: "upvote")
      expect(new_like.valid?).to be_truthy
    end
  end
end
