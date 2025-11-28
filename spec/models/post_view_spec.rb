require 'rails_helper'

RSpec.describe PostView, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }

  describe "view tracking" do
    it "links a user to viewed posts" do
      user = create(:user)
      post_record = create(:post)

      view = create(:post_view, user: user, post: post_record)

      expect(user.post_views).to include(view)
      expect(user.viewed_posts).to include(post_record)
    end
  end
end
