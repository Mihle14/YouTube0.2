require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:matching_post) { create(:post, title: "Ruby on Rails", description: "Rails tutorial", user: user) }
  let!(:other_post) { create(:post, title: "JavaScript Guide", description: "JS tutorial", user: user) }

  describe "GET #index" do
    context "when query is present" do
      it "returns posts matching the query" do
        get :index, params: { query: "Rails" }

        expect(assigns(:posts)).to include(matching_post)
        expect(assigns(:posts)).not_to include(other_post)
      end
    end
  end
end

