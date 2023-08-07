class CreateUserBehaviors < ActiveRecord::Migration[5.1]
  def change
    create_table :user_behaviors do |t|
      t.integer :user_id
      t.string :page_name
      t.datetime :timestamp

      t.timestamps
    end
  end
end
