class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :message_id
      t.text :content

      t.timestamps
    end
    add_index :replies, :user_id
    add_index :replies, :message_id
  end
end
