class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :name
      t.string  :network_type
      t.string  :address
      t.boolean  :privacy,                      :default => false
      t.integer  :network_participations_count, :default => 0

      t.timestamps
    end
  end
end
