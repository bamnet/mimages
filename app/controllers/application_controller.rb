class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :require_auth!

  private
    def require_auth!
      if Current.session.nil?
        redirect_to sign_in_path
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
      if session = Session.find_by_id(cookies.signed[:session_token])
        Current.session = session
      end
    end
end
