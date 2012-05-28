class CreateNetworkParticipations < ActiveRecord::Migration
  def change
    create_table :network_participations do |t|
      t.integer :user_id
      t.integer :network_id
      t.boolean :approved,   :default => false

      t.timestamps
    end
    add_index :network_participations, :user_id
    add_index :network_participations, :network_id
  end
end
