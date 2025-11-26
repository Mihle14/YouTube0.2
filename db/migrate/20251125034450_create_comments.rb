class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.text :body
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.uuid :parent_id

      t.timestamps
    end
  end
end
