require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post_record) { create(:post, user: user) }

  it "allows a comment to have replies" do
    parent = create(:comment, user: user, post: post_record, body: "Parent comment")
    reply = create(:comment, user: user, post: post_record, parent: parent, body: "Reply comment")

    expect(parent.replies).to include(reply)
    expect(reply.parent).to eq(parent)
  end
end
