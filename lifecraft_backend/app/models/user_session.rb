class UserSession < Authlogic::Session::Base
  # attr_accessible :title, :body
  attr_accessor :current_quest
end
