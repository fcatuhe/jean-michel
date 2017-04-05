class AddResultToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :result, :integer
  end
end
