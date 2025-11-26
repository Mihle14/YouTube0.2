class AddUserToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :user, null: true, foreign_key: true, type: :uuid
  end
end
