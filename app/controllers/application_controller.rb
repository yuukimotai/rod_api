class ApplicationController < ActionController::API
  private
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
  def current_user
    rodauth.rails_account
  end
end
