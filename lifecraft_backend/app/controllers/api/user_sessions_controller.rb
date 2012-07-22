class Api::UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    user_params = {}
    user_params[:email] = params[:email]
    user_params[:password] = "derp"
    user_params[:password_confirmation] = "derp"

    @user = User.find_by_email(user_params[:email])
    (@user = User.new(user_params) and @user.save) if @user.nil?

    @user_session = UserSession.new(user_params)
    render :json => @user
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
