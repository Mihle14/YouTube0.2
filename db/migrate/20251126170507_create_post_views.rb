class CreatePostViews < ActiveRecord::Migration[7.1]
  def change
    create_table :post_views, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :post, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
