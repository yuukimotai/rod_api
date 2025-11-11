class ApplicationController < ActionController::API
  private
  include Pundit
  after_action :set_jwt_token

  def set_jwt_token
    if rodauth.use_jwt? && rodauth.valid_jwt?
      response.headers["Authorization"] = rodauth.session_jwt
      # cookies.signed[:access_token] = {
      #   value: rodauth.session_jwt,
      #   httponly: true,
      #   secure: Rails.env.production?,
      #   same_site: :lax
      # }
    end
  end
  def authenticate
    rodauth.require_account # redirect to login page if not authenticated
  end
  def current_user
    rodauth.rails_account
  end
  def current_admin
    rodauth.rails_account if rodauth.admin_logged_in?
  end
end
