require "rails_helper"

RSpec.describe "Sidebar", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "when the user is not signed in" do
    it "does not show the sidebar" do
      visit root_path
      expect(page).not_to have_selector("aside")
      expect(page).not_to have_content("Home")
      expect(page).not_to have_content("Shorts")
    end
  end

  context "when the user is signed in" do
    let(:user) { User.create!(email: "mihlentsaluba14@gmail.com", password: "password") }

    before do
      sign_in user
      visit root_path
    end

    it "displays the sidebar with navigation links" do
      expect(page).to have_selector("aside")
      expect(page).to have_content("Home")
      expect(page).to have_content("Shorts")
      expect(page).to have_content("Subscribers")
      expect(page).to have_content("Library")
      expect(page).to have_content("Playlists")
      expect(page).to have_content("History")
      expect(page).to have_content("Liked Videos")
      expect(page).to have_content("Watch Later")
    end

    it "has icons for each navigation item" do
      expect(page).to have_selector("i.fas.fa-home")
      expect(page).to have_selector("i.fas.fa-play-circle")
      expect(page).to have_selector("i.fas.fa-users")
      expect(page).to have_selector("i.fas.fa-photo-video")
      expect(page).to have_selector("i.fas.fa-list")
      expect(page).to have_selector("i.fas.fa-history")
      expect(page).to have_selector("i.fas.fa-thumbs-up")
      expect(page).to have_selector("i.fas.fa-clock")
    end
  end
end
