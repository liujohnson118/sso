class SessionActivityController < ApplicationController

  def destroy
    invalidate_user_session
  end

end
