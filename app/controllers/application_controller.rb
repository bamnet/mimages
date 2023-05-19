# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_auth!

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user

  private

  def require_auth!
    return unless session[:user_id].nil?

    redirect_to sign_in_path
  end
end
