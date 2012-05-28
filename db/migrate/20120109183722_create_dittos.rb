class CreateDittos < ActiveRecord::Migration
  def change
    create_table :dittos do |t|
      t.integer :user_id
      t.integer :dittoable_id
      t.string :dittoable_type

      t.timestamps
    end
    add_index :dittos, :dittoable_id
    add_index :dittos, :user_id
  end
end
