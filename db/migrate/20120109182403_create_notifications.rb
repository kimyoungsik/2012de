class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :notification_type
      t.integer :notifiable_id
      t.string :notifiable_type
      t.boolean :read, default: false
      t.string :message
      t.string :subject
      t.string :url
      t.integer :sender_id

      t.timestamps
    end
  end
end
