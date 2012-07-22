class Quest
  attr_accessor :user, :activity

  def to_json
    {
      :user_id => @user.id,
      :activity_id => @activity.id
    }.to_json
  end
end
