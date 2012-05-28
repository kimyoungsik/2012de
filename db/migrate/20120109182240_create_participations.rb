class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :seed_id
      t.string :status

      t.timestamps
    end
    add_index :participations, :user_id
    add_index :participations, :seed_id
  end
end
