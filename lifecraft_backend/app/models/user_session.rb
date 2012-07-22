class UserSession < Authlogic::Session::Base
  # attr_accessible :title, :body
  attr_accessible :current_quest
end
