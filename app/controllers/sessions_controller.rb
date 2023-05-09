class SessionsController < ApplicationController
  skip_before_action :require_auth!, only: %i[ new ]

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def destroy
    @session.destroy; redirect_to(root_path, notice: "That session has been logged out")
  end

  private
    def set_session
      @session = Current.user.sessions.find(params[:id])
    end
end
