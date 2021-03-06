class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find

      Rails.logger.debug "\033[33m#{@current_user_session.inspect}\033[0m"
      @current_user_session
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        render :json => {:notice => "user login required"}
        # redirect_to new_user_session_url
        # return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        render :json => {:notice => "must be logged out"}
        # redirect_to account_url
        # return false
      end
    end

    def store_location
      # TODO MAKE THIS NOT SUCK SIGNUP HARDCODED LOL
      session[:return_to] = "/signup"
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end 
end
