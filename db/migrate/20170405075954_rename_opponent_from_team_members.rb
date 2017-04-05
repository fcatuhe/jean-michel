class RenameOpponentFromTeamMembers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :team_members, :opponent, index: true
    add_reference :team_members, :player, index: true
  end
end
