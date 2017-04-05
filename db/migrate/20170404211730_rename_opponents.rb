class RenameOpponents < ActiveRecord::Migration[5.0]
  def change
    rename_table :opponents, :players
  end
end
