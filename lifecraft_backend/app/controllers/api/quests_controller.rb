class Api::QuestsController < ApplicationController
  def new
    sesh = current_user_session
    sesh.current_quest = Quest.new
    sesh.current_quest.user = current_user
    sesh.current_quest.activity = Activity.find(params[:activity_id])

    render :text => sesh.instance_variables
    #render :text => "{success: true}"
  end

  def show
    sesh = current_user_session
    if not sesh.nil?
      render :text => sesh.instance_variables
      #render :json => sesh.current_quest
    else
      render :text => "{success: false}"
    end
  end

  def complete_quest
    sesh = current_user_session
    if not sesh.nil?
      sesh.current_quest = nil
      user = current_user
      user.experience += 10 if !user.nil? && !user.experience.nil?
      user.save
    end
  end
end
