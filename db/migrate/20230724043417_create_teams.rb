class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.integer :manager_id

      t.timestamps
    end
  end
end
