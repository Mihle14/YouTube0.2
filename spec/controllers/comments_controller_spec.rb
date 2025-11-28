require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post_record) { create(:post, user: other_user) }

  describe "POST /comments" do
    before { sign_in user }

    it "creates a comment on a post" do
      expect {
        post post_comments_path(post_record), params: { comment: { body: "Nice video!" } }
      }.to change(Comment, :count).by(1)

      expect(response).to redirect_to(post_path(post_record))
    end

    it "creates a notification if commenting on someone else’s post" do
      expect {
        post post_comments_path(post_record), params: { comment: { body: "Nice video!" } }
      }.to change(Notification, :count).by(1)
    end

    it "does NOT create a notification on your own post" do
      my_post = create(:post, user: user)

      expect {
        post post_comments_path(my_post), params: { comment: { body: "Self comment" } }
      }.not_to change(Notification, :count)
    end
  end

  describe "Nested replies" do
    before { sign_in user }

    it "allows a comment to reply to another comment" do
      parent = create(:comment, user: other_user, post: post_record, body: "Original")
      expect {
        post post_comments_path(post_record), params: { comment: { body: "Reply!", parent_id: parent.id } }
      }.to change(parent.replies, :count).by(1)
    end
  end
end
