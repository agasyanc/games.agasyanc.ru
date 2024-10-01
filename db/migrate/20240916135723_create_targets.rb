class CreateTargets < ActiveRecord::Migration[7.1]
  def change
    create_table :targets do |t|
      t.string :code
      t.string :shape
      t.string :moves
      t.string :colors
      t.string :transformation
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
