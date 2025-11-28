require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:message) }

  describe "unread scope" do
    it "returns only unread notifications" do
      user = create(:user)
      post_record = create(:post)

      unread = create(:notification, user: user, post: post_record, message: "Unread message", read: false)
      read_n = create(:notification, user: user, post: post_record, message: "Read message", read: true)

      expect(Notification.unread).to include(unread)
      expect(Notification.unread).not_to include(read_n)
    end
  end
end
