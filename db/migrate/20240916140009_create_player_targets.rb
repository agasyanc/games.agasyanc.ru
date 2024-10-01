class CreatePlayerTargets < ActiveRecord::Migration[7.1]
  def change
    create_table :player_targets do |t|
      t.references :player, null: false, foreign_key: true
      t.references :target, null: false, foreign_key: true

      t.timestamps
    end
  end
end
