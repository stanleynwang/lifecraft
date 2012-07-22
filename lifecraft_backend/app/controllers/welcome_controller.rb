class WelcomeController < ApplicationController
  def self.partial_method(name)
    define_method(:"_#{name}") do
      render :action => name, :layout => false
    end
  end

  def index
  end

  def about
  end

  partial_method :index
  partial_method :about
end
