class AddActorToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :actor_id, :uuid
  end
end
