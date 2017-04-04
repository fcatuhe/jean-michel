class CreateSigns < ActiveRecord::Migration[5.0]
  def change
    create_table :signs do |t|
      t.string :description

      t.timestamps
    end
  end
end
