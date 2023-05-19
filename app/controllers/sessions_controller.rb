# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_auth!, only: %i[ new ]

  def new
    @user = User.new
  end

  def destroy
    reset_session
    session[:user_id] = nil
    redirect_to(root_path)
  end
end
