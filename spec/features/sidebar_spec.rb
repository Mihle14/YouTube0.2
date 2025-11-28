require "rails_helper"

RSpec.describe "Sidebar", type: :system do
  let(:user) { create(:user) }
  let!(:post1) { create(:post) }
  let!(:post2) { create(:post) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it "displays navigation links" do
    visit root_path

    expect(page).to have_content("Home")
    expect(page).to have_content("Trending")
    expect(page).to have_content("Library")
    expect(page).to have_content("Watch later")
    expect(page).to have_content("Liked videos")
  end

  it "displays recent history or placeholder text" do
    visit root_path

    expect(page).to have_text("No history yet.")

    PostView.create!(user: user, post: post1)
    PostView.create!(user: user, post: post2)

    visit root_path
    expect(page).to have_link(post1.title, href: post_path(post1))
    expect(page).to have_link(post2.title, href: post_path(post2))
  end
end
