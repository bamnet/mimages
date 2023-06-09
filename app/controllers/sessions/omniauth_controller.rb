# frozen_string_literal: true

class Sessions::OmniauthController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_auth!

  def create
    @user = User.create_with(user_params).find_or_initialize_by(omniauth_params)

    if @user.save
      reset_session
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'Signed in'
    else
      redirect_to sign_in_path, alert: 'Authentication failed'
    end
  end

  def failure
    redirect_to sign_in_path, alert: params[:message]
  end

  private

  def user_params
    { email: omniauth.info.email }
  end

  def omniauth_params
    { provider: omniauth.provider, uid: omniauth.uid }
  end

  def omniauth
    request.env['omniauth.auth']
  end
end
