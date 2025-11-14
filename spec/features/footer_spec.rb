require 'rails_helper'

RSpec.describe "Footer", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "displays the footer content correctly" do
    visit root_path
    expect(page).to have_selector("footer h2", text: "YouTube0.2")
    expect(page).to have_link("About", href: "#")
    expect(page).to have_link("Help", href: "#")
    expect(page).to have_link("Terms", href: "#")
    expect(page).to have_link("Privacy", href: "#")
    expect(page).to have_content("© #{Time.current.year} YouTube0.2. All rights reserved.")
  end
end