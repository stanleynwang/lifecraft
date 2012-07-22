class Api::UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    user_params = {}
    user_params[:email] = params[:email]
    user_params[:password] = params[:password]
    @user_session = UserSession.new(user_params)
    if @user_session.save
      render :text => "{success: true}"
    else
      render :text => "{success: false}"
    end
  end

  def destroy
    if current_user_session.nil?
      render :text => "{success: false}"
    else
      current_user_session.destroy
      render :text => "{success: true}"
    end
  end
end
