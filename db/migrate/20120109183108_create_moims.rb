class CreateMoims < ActiveRecord::Migration
  def change
    create_table :moims do |t|
      t.string :title
      t.text     :description
      t.integer  :user_id
      t.string   :location
      t.datetime :event_time
      t.boolean  :hasMap,         :default => false
      t.string   :mapCoordinates, :default => ":N/A"
      t.string   :mapAddress,     :default => ":N/A"
      t.integer  :moimable_id
      t.string   :moimable_type

      t.timestamps
    end
    add_index :moims, :moimable_id
    add_index :moims, :user_id
  end
end
