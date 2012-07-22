class WelcomeController < ApplicationController
  def index
  end

  def _about
    render :layout => false
  end
end
