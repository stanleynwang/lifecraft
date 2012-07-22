class Api::QuestsController < ApplicationController
  # this should probably be create by definition of what we are doing... :|
  def new
    @quest = Quest.new

    @quest.user = current_user
    @quest.activity = Activity.find(params[:activity_id])
    @quest.save

    current_user.save

    render :json => @quest
  end

  def show
    if not params[:id].nil?
      render :json => Quest.find(params[:id])
    else
      render :json => {:notice => "need :id"}
    end
  end

  def current
    #TODO OH GOD THIS IS HORRIBLE
    render :json => current_user.quests.reject{|x| x.completed }
  end

  def complete_quest
    @user  = current_user
    @quest = Quest.find(params[:quest_id])
    if (not @quest.nil?) and (@quest.user == @user) and (not @quest.completed)
      @quest.completed = true
      @quest.save
      @user.experience += 400
      @user.save
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end
end
