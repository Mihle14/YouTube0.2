require 'rails_helper'

RSpec.describe LikesController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post_record) { create(:post, user: other_user) }

  describe "POST /likes" do
    before { sign_in user }

    it "creates a like on someone else’s post" do
      expect {
        post post_likes_path(post_record), params: { like_type: "like" }
      }.to change(Like, :count).by(1)

      expect(response).to redirect_to(post_path(post_record))
    end

    it "sends a notification if liking another user’s post" do
      expect {
        post post_likes_path(post_record), params: { like_type: "like" }
      }.to change(Notification, :count).by(1)
    end

    it "does NOT send notification if liking own post" do
      own_post = create(:post, user: user)

      expect {
        post post_likes_path(own_post), params: { like_type: "like" }
      }.not_to change(Notification, :count)
    end
  end
end
