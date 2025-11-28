require "rails_helper"

RSpec.describe "Likes", type: :request do
  let!(:post_record) { create(:post, user: create(:user)) }
  let(:user) { create(:user) }

  describe "POST /posts/:post_id/likes" do
    it "requires authentication" do
      post "/posts/#{post_record.id}/likes", params: { like_type: "like" }
      expect(response).to have_http_status(401).or redirect_to("/users/sign_in")
    end

    it "creates a like when signed in" do
      sign_in user
      expect {
        post "/posts/#{post_record.id}/likes", params: { like_type: "like" }
      }.to change(Like, :count).by(1)

      expect(response).to redirect_to("/posts/#{post_record.id}")
    end

    it "sends a notification when liking someone else's post" do
      sign_in user
      expect {
        post "/posts/#{post_record.id}/likes", params: { like_type: "like" }
      }.to change(Notification, :count).by(1)
    end

    it "does NOT notify if liking own post" do
      own_post = create(:post, user: user)
      sign_in user
      expect {
        post "/posts/#{own_post.id}/likes", params: { like_type: "like" }
      }.to change(Notification, :count).by(0)
    end
  end
end
