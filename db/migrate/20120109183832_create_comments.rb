class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :kit_id

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :kit_id
  end
end
