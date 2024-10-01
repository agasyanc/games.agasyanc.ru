class Player < ApplicationRecord
  has_many :switches
  has_many :targets
  has_many :player_targets
  has_many :target_rooms, through: :player_targets, source: :target

  after_create :set_default_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
        #  :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def name
    @name.presence || "Player#{id}"
  end

  def name=(value)
    @name=value
  end

  def total_on_duration
    on_switcher = nil
    total_duration = 0

    switches.order(:created_at).each do |switch|
      if switch.on && on_switcher.nil?
        # Switch is turned on, track the time
        on_switcher = switch
      elsif !switch.on && on_switcher.present?
        # Switch is turned off, calculate the duration it was "on"
        off_switcher = switch
        total_duration += off_switcher.created_at - on_switcher.created_at  # Difference in seconds
        on_switcher = nil  # Reset on_switcher for the next cycle
      end
    end

    total_duration
  end



  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |player|
      player.email = auth.info.email
      # player.password = Devise.friendly_token[0, 20]
      # You can add other fields from auth here as needed, such as name, image, etc.
    end
  end

  private
    def set_default_name
      self.update(name: "Player#{self.id}") if self.name.blank?
    end
end
