require 'rails_helper'

RSpec.describe Post, type: :model do
  it "can be created" do
    post = Post.new
    expect(post).to be_a(Post)
  end

  it "can have an attached image" do
    post = Post.new
    post.image.attach(
      io: File.open(Rails.root.join("spec/fixtures/files/test_image.png")),
      filename: "test_image.png",
      content_type: "image/png"
    )
    expect(post.image).to be_attached
  end
end
