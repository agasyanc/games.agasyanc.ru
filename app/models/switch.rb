class Switch < ApplicationRecord
  belongs_to :player
  after_commit :send_status


  def self.on_count
    where(on: true).count
  end


  def self.turn_off
    if Switch.count > 0 and Switch.last.on
      # player with email
      player = Player.find_by(email: 'agasyanc@gmail.com')
      if player && rand < 0.33
        Switch.create!(player: player, on: false, time: Time.now)
      end
    end
  end

  private
    def send_status
      @last_switch = Switch.last

      begin

      ActionCable.server.broadcast(
        "SwitcherChannel", {
          on: @last_switch.on,
          player: @last_switch.player.name,
          time: @last_switch.time
        }.to_json
      )
      rescue Redis::CannotConnectError => e
        puts e

      end
    end
end
