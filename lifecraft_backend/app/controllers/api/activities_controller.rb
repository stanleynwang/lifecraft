class Api::ActivitiesController < ApplicationController
  def show
    activity = Activity.find(params[:id])
    render :json => activity
  end

  def find
    date = Date.parse(params[:date])
    if !params[:lat] || !params[:long]
      render :json => {:error => 'Lat and long required'}, :status => :bad_request
    else
      location = [params[:lat].to_f, params[:long].to_f]
      radius = params[:radius] ? params[:radius].to_f : 1.5
      render :json => Activity.near(location, radius)
    end
  end
end
