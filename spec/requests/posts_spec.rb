require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:valid_params) { { post: { title: "Test Post", description: "Test Description" } } }

  before do
    sign_in user
  end

  it "creates a post and redirects when valid" do
    expect {
      post posts_path, params: valid_params
    }.to change(Post, :count).by(1)

    expect(response).to redirect_to(post_path(Post.last))
  end
end
