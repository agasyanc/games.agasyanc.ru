class TargetController < ApplicationController
  def index
    @target = Target.new
    @targets = Target.all
  end

  def create
    return unless player_signed_in?

    @target = Target.new(target_params)
    @target.player = current_player
    if @target.save
      redirect_to target_game_path(code: @target.code)
      flash[:notice] = "Target created successfully"
    else
      render :index
      flash[:alert] = "Target creation failed"
      p @target.errors.full_messages
    end
  end

  def game
    @target = Target.find_by(code: params[:code])
  end

  private
  def target_params
    params.require(:target).permit(:code)
  end
end
