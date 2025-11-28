require "rails_helper"

RSpec.describe "Footer", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "displays all footer links and current year" do
    visit root_path

    expect(page).to have_link("About")
    expect(page).to have_link("Help")
    expect(page).to have_link("Terms")
    expect(page).to have_link("Privacy")
    expect(page).to have_text("© #{Time.current.year} YouTube0.2")
  end
end
