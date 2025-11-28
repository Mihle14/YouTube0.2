require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should have_many(:notifications).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:post_views).dependent(:destroy) }

  it { should validate_uniqueness_of(:email).case_insensitive.with_message("has already been used before") }
  it { should validate_uniqueness_of(:name).with_message("has already been used before").allow_nil }

  it "validates surname uniqueness scoped to name" do
    user = create(:user, name: "Mihle", surname: "Smith")

    dupe = build(:user, name: "Mihle", surname: "Smith")
    expect(dupe.valid?).to be_falsey
    expect(dupe.errors[:surname]).to include("with this name has already been used before")
  end
end
