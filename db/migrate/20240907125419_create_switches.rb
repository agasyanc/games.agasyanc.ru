class CreateSwitches < ActiveRecord::Migration[7.1]
  def change
    create_table :switches do |t|
      t.boolean :on, null: false
      t.datetime :time, null: false
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
