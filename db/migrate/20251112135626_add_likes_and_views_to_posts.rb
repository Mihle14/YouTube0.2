class AddLikesAndViewsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :likes, :integer
    add_column :posts, :views, :integer
  end
end
