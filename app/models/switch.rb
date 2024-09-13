class Switch < ApplicationRecord
  belongs_to :player
  after_commit :send_status


  def self.best_players(count)
    Player.joins(:switches)
      .where(switches: {on: true})
      .group('players.id')
      .order('COUNT(switches.id) DESC')
      .limit(count)
  end

  def self.mean_off
    avg_time_in_seconds = Switch.where(on: false).average("strftime('%s', time)").to_f
    Time.at(avg_time_in_seconds).to_datetime if avg_time_in_seconds.present?
  end

  def self.total_on_duration
    on_switcher = nil
    total_duration = 0

    Switch.order(:created_at).each do |switcher|
      if switcher.on == true && on_switcher.nil?
        # Switch is turned on, track the time
        on_switcher = switcher
      elsif switcher.on == false && on_switcher.present?
        # Switch is turned off, calculate the duration it was "on"
        off_switcher = switcher
        total_duration += off_switcher.created_at - on_switcher.created_at  # Difference in seconds
        on_switcher = nil  # Reset on_switcher for the next cycle
      end
    end

    total_duration
  end

  def self.total_off_duration
    off_switcher = nil
    total_duration = 0

    Switch.order(:created_at).each do |switcher|
      if switcher.on == false && off_switcher.nil?
        # Switch is turned off, track the time
        off_switcher = switcher
      elsif switcher.on == true && off_switcher.present?
        # Switch is turned on, calculate the duration it was "off"
        on_switcher = switcher
        total_duration += on_switcher.created_at - off_switcher.created_at  # Difference in seconds
        off_switcher = nil  # Reset off_switcher for the next cycle
      end
    end

    # If the last switch state was "off", calculate the duration until the current time
    if off_switcher.present?
      total_duration += Time.now - off_switcher.created_at
    end

    total_duration
  end

  def self.total_on_duration_for_player_with_any_off(player_id)
    on_switcher = nil
    total_duration = 0

    # Fetch all switches ordered by created_at
    Switch.order(:created_at).each do |switch|
      if switch.player_id == player_id && switch.on && on_switcher.nil?
        # Switch is turned on for the specific player, track the time
        on_switcher = switch
      elsif !switch.on && on_switcher.present?
        # Switch is turned off by any player, calculate the duration it was "on"
        off_switcher = switch
        total_duration += off_switcher.created_at - on_switcher.created_at  # Difference in seconds
        on_switcher = nil  # Reset on_switcher for the next cycle
      end
    end

    # If the last switch state was "on" for the specific player, calculate the duration until now
    if on_switcher.present?
      total_duration += Time.now - on_switcher.created_at
    end

    total_duration
  end



  def self.on_count
    where(on: true).count
  end


  def self.turn_off
    if Switch.count > 0 and Switch.last.on
      # player with email
      player = Player.find_by(email: 'agasyanc@gmail.com')
      if player && rand < 0.9
        Switch.create!(player: player, on: false, time: Time.now)
      end
    end
  end

  private
    def send_status
      @last_switch = Switch.last

      return unless @last_switch.present?

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
