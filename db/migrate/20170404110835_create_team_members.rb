class CreateTeamMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_members do |t|
      t.references :team, foreign_key: true
      t.references :opponent, foreign_key: true

      t.timestamps
    end
  end
end
