class CreateSeeds < ActiveRecord::Migration
  def change
    create_table :seeds do |t|
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :seeds, :user_id    
  end
end
