<<<<<<< Updated upstream
class Quest < ActiveRecord::Base
  belongs_to :user
  # has_one :user
  belongs_to :activity
=======
class Quest
  attr_accessor :user, :activity

  def to_json
    {
      :user_id => @user.id,
      :activity_id => @activity.id
    }.to_json
  end
>>>>>>> Stashed changes
end
