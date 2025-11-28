class AddUniqueLikeIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :likes, [:user_id, :post_id, :like_type], unique: true
  end
end
