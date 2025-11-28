# spec/features/navbar_spec.rb
require "rails_helper"

RSpec.describe "Navbar", type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "displays flash messages after creating a post" do
    visit new_post_path

    fill_in "Title", with: "Test Post"
    fill_in "Description", with: "Test description"

    click_button "Create Post", match: :first

    expect(page).to have_selector("div.bg-green-500", text: "Post was successfully created.")
  end
end
