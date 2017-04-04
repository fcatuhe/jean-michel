class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :game, foreign_key: true
      t.references :sign, foreign_key: true

      t.timestamps
    end
  end
end
