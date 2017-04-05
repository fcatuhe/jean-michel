class Game < ApplicationRecord
  belongs_to :room
  belongs_to :forfeit
  has_many :teams

  delegate :players, to: :room

  def referee(player, designated_player)
    if teams.map { |team| team.players.sort == [player, designated_player].sort }.any?
      teams.each do |team|
        if team.players.include?(player)
          team.winner!
          team.players.each { |player| player.score += 1; player.save }
        else
          team.looser!
        end
      end
    else
      teams.each do |team|
        if team.players.include?(player)
          team.looser!
        else
          team.winner!
          team.players.each { |player| player.score += 1; player.save }
        end
      end
    end
  end
end
