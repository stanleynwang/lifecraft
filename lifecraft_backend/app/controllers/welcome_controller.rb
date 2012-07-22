class WelcomeController < ApplicationController
  def index
  end

  def about
  end

  def _about
    render :action => :about, :layout => false
  end
end
