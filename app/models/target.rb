class Target < ApplicationRecord
  belongs_to :player
  has_many :player_targets
  has_many :players, through: :player_targets

  validates :code, presence: true
  validates :code, uniqueness: true

end
