class CreateKits < ActiveRecord::Migration
  def change
    create_table :kits do |t|
      t.integer :user_id
      t.text     :content
      t.integer  :kitable_id
      t.string   :kitable_type
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size

      t.timestamps
    end
    add_index :kits, :user_id
    add_index :kits, :kitable_id
  end
end
