class Player < ApplicationRecord
  has_many :switches
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
