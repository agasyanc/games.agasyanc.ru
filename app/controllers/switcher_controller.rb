class SwitcherController < ApplicationController
  before_action :authenticate_player!, only: [:off]

  def index
    @switches = Switch.all
    @switch = Switch.new
    @current = Switch.last
    @on_count = Switch.on_count
    @last_off = Switch.where(on: false).last || nil
    @best_players = Switch.best_players(5)
    @mean_off = Switch.mean_off
    @total_on_duration = Switch.total_on_duration
    @total_off_duration = Switch.total_off_duration

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
      if !last_switch.on
        @switch = Switch.create!(player: current_player, on: true, time: Time.now)
      end

    end

  end


  def off
    return if current_player.email != 'agasyanc@gmail.com'

    last_switch = Switch.last

    if last_switch.on
      @switch = Switch.create!(player: current_player, on: false, time: Time.now)
    end

  end

end
