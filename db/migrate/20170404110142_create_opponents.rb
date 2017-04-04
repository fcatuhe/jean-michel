class CreateOpponents < ActiveRecord::Migration[5.0]
  def change
    create_table :opponents do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
