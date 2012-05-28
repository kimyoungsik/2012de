class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.string :email
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
