class Api::UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def create
    # email
    # password
    # password_confirmation
    user_params = {}
    user_params[:email] = params[:email]
    user_params[:password] = "derp"
    user_params[:password_confirmation] = params[:password_confirmation]
    @user = User.new(user_params)

    if @user.save
      render :text => "{success: true}"
    else
      render :text => "{success: false}"
    end

  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end