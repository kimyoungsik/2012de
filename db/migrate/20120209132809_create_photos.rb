class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.references :photoable, :polymorphic => true

      t.timestamps
    end
    add_index :photos, :photoable_id
    add_index :photos, :user_id
  end
end
