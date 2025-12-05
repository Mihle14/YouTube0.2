class CreateChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :channels, id: :uuid do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
