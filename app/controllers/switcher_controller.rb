class SwitcherController < ApplicationController
  # before_action :authenticate_player!, only: [:off]

  def index

    @switches = Switch.all
    @switch = Switch.new
    @current = Switch.last

    @best_on_players = Switch.best_on_players(3)
    @best_off_players = Switch.best_off_players(3)

    @total_on_duration = Switch.total_on_duration
    @total_off_duration = Switch.total_off_duration

    return unless player_signed_in?

    if params[:commit] == 'Start'
      if @switches.count > 0
        render plain: 'Game already stated', status: 400
        return
      end
      if player_signed_in? and current_player.email == 'agasyanc@gmail.com'
        @switch = Switch.create!(player: current_player, on: false, time: Time.now)
      end
    end

    if params[:switch] && params[:switch][:commit] == 'On'
      last_switch = Switch.last
      @switch = Switch.create!(player: current_player, on: !last_switch.on, time: Time.now)
      redirect_to switcher_url
    end

  end

end
