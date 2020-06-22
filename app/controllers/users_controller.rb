class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create

  end

  private

  def user_create_params
    params.require(:user).permit(:name, :default_service_provider_id, :description, :timezone,
                                    :ticket_enabled, :shortcode_id, :twilio_sid, :twilio_auth_token)
  end


end