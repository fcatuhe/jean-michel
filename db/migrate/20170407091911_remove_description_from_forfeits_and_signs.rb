class RemoveDescriptionFromForfeitsAndSigns < ActiveRecord::Migration[5.0]
  def change
    remove_column :forfeits, :description
    remove_column :signs, :description
  end
end
