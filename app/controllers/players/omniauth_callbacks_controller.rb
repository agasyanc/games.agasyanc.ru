class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :google_oauth2

  def google_oauth2
    @player = Player.from_omniauth(request.env["omniauth.auth"])

    if @player.persisted?
      sign_in_and_redirect @player, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_player_registration_url, alert: @player.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end
end
