require "rails_helper"

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }
  let!(:notification) { create(:notification, user: user, message: "Test message", read: false) }

  describe "GET /notifications" do
    it "requires authentication" do
      get "/notifications"
      expect(response).to redirect_to("/users/sign_in")
    end

    it "shows notifications when signed in" do
      sign_in user
      get "/notifications"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test message")
    end
  end

  describe "PATCH /notifications/:id/mark_as_read" do
    it "marks a notification as read" do
      sign_in user
      patch "/notifications/#{notification.id}/mark_as_read"

      expect(notification.reload.read).to eq(true)
      expect(response).to redirect_to("/notifications")
    end
  end
end
