class CreateTeamMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :team_memberships do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
