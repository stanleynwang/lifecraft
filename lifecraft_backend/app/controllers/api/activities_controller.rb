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
      activities = Activity.near(location, radius).to_a
      activities.map! do |activity|
        is_current = current_user.quests.collect { |q| q.activity.id }.include?(activity.id)
        data = activity.as_json
        data[:is_current] = is_current if is_current
        data
      end
      render :json => activities
    end
  end
end
