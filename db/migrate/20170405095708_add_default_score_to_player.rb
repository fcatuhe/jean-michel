class AddDefaultScoreToPlayer < ActiveRecord::Migration[5.0]
  def change
    change_column :players, :score, :integer, default: 0
  end
end
