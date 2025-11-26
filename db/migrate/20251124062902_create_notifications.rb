class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.string :message
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
