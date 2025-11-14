require "rails_helper"

RSpec.describe "Navbar", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "when the user is not signed in" do
    it "shows the brand, search bar, and Sign In link" do
      visit root_path
      expect(page).to have_selector("span", text: "YouTube0.2")
      expect(page).to have_selector("img[alt='YouTube Logo']")
      expect(page).to have_selector("input[placeholder='Search']")
      expect(page).to have_selector("button i.fas.fa-search")
      expect(page).to have_link("Sign In", href: new_user_session_path)
      expect(page).not_to have_link("Sign Out")
      expect(page).not_to have_selector("i.fas.fa-user-circle")
    end
  end

  context "when the user is signed in" do
    let(:user) { User.create!(email: "mihlentsaluba14@gmail.com", password: "password") }

    before do
      sign_in user
      visit root_path
    end

    it "shows upload, notifications, and user menu" do
      expect(page).to have_selector("i.fas.fa-video")
      expect(page).to have_selector("i.fas.fa-bell")
      expect(page).to have_selector("i.fas.fa-user-circle")
      expect(page).to have_content(user.email)
      expect(page).to have_link("Sign Out", href: destroy_user_session_path)
    end
  end
end