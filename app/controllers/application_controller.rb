class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::InvalidAuthenticityToken do
    redirect_to new_user_session_path, alert: "Your session has expired. Please log in again."
  end
end
