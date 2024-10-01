class PlayerTarget < ApplicationRecord
  belongs_to :player
  belongs_to :target
end
