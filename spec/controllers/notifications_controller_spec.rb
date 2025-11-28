require 'rails_helper'

RSpec.describe NotificationsController, type: :request do
  let(:user) { create(:user) }
  let!(:notification) { create(:notification, user: user, post: create(:post), message: "Test", read: false) }

  describe "GET /notifications" do
    before { sign_in user }

    it "loads notifications page" do
      get notifications_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(notification.message)
    end
  end

  describe "PATCH /notifications/:id/mark_as_read" do
    before { sign_in user }

    it "marks a notification as read" do
      patch mark_as_read_notification_path(notification)

      expect(notification.reload.read).to eq(true)
      expect(response).to redirect_to(notifications_path)
    end
  end
end

