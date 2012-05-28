class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :attendee_id
      t.integer :attended_id

      t.timestamps
    end
    add_index :attendances, :attendee_id
    add_index :attendances, :attended_id
  end
end
