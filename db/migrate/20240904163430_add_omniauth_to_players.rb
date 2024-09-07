class AddOmniauthToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :provider, :string
    add_column :players, :uid, :string

    add_index :players, [:provider, :uid], unique: true
  end
end
