class Api::QuestsController < ApplicationController
  # this should probably be create by definition of what we are doing... :|
  def new
    @quest = Quest.new

    @quest.user = current_user
    @quest.activity = Activity.find(params[:activity_id])
    @quest.save

    current_user.current_quest = @quest
    current_user.save

    render :json => @quest
  end

  def show
    if not params[:id].nil?
      @quest = (params[:id] == 'current_user' ? current_user.current_quest : Quest.find(params[:id]))
      render :json => (!@quest.nil? ? @quest : {:notice => "no current quest"})
    else
      render :json => {:notice => "need :id or 'current_user'"}
    end
  end

  def complete_quest
    @user  = current_user
    @quest = @user.current_quest
    if not @quest.nil?
      @user.experience += 400
      @user.current_quest = nil
      @user.save
      render :json => {:success => true}
    else
      render :json => {:success => false}
    end
  end
end
