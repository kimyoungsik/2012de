class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.integer :user_id
      t.integer :seed_id

      t.timestamps
    end
    add_index :supports, :user_id
    add_index :supports, :seed_id    
  end
end
