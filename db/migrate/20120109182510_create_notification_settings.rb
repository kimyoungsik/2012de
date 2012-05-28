class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.integer :user_id
      t.boolean :kit_notify,                  :default => true
      t.boolean :seed_kit_notify,             :default => true
      t.boolean :moim_kit_notify,             :default => true
      t.boolean :comment_notify,              :default => true
      t.boolean :other_comment_notify,        :default => true
      t.boolean :reply_notify,                :default => true
      t.boolean :friendship_notify,           :default => true
      t.boolean :friendship_acceptance_notify, :default => true
      t.timestamps
    end
  end
end
