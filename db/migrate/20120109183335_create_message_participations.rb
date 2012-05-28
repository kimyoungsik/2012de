class CreateMessageParticipations < ActiveRecord::Migration
  def change
    create_table :message_participations do |t|
      t.integer :user_id
      t.integer :message_id
      t.boolean :read, :default => false

      t.timestamps
    end
    add_index :message_participations, :user_id
    add_index :message_participations, :message_id
  end
end
