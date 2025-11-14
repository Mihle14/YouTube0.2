require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:valid_attributes) do
    { title: "Test Post", description: "This is a test" }
  end

  let(:invalid_attributes) do
    { title: "", description: "No title" }
  end

  let!(:post_record) { Post.create!(title: "Existing Post", description: "Content") }

  describe "GET /posts" do
    it "returns a success response" do
      get posts_path
      expect(response).to be_successful
      expect(assigns(:posts)).to include(post_record)
    end
  end

  describe "GET /posts/:id" do
    it "returns a success response and increments views" do
      expect {
        get post_path(post_record)
      }.to change { post_record.reload.views }.by(1)
      expect(response).to be_successful
    end
  end

  describe "GET /posts/new" do
    it "assigns a new post" do
      get new_post_path
      expect(assigns(:post)).to be_a_new(Post)
      expect(response).to be_successful
    end
  end

  describe "POST /posts" do
    context "with valid params" do
      it "creates a new post and redirects" do
        expect {
          post posts_path, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)

        expect(response).to redirect_to(post_path(Post.last))
      end
    end

    context "with invalid params" do
      it "does not create a post and renders new" do
        expect {
          post posts_path, params: { post: invalid_attributes }
        }.not_to change(Post, :count)

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /posts/:id" do
    context "with valid params" do
      it "updates the post and redirects" do
        patch post_path(post_record), params: { post: { title: "Updated" } }
        expect(post_record.reload.title).to eq("Updated")
        expect(response).to redirect_to(post_record)
      end
    end

    context "with invalid params" do
      it "does not update and renders edit" do
        patch post_path(post_record), params: { post: { title: "" } }
        expect(post_record.reload.title).not_to eq("")
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /posts/:id" do
    it "deletes the post and redirects to index" do
      expect {
        delete post_path(post_record)
      }.to change(Post, :count).by(-1)

      expect(response).to redirect_to(posts_path)
    end
  end
end
