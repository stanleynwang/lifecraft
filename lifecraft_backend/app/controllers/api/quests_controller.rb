class QuestsController < ApplicationController
  def new
    sesh = current_user_session
    sesh.current_quest = Quest.new
    sesh.current_quest.user = current_user
    sesh.current_quest.activity = Activity.find(params[:activity_id])
  end

  def show
    sesh = current_user_session
    sesh.quest.to_json if not sesh.nil?
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
