class AddPlayedToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :played, :boolean, default: false
  end
end
