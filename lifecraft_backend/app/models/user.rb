class User < ActiveRecord::Base
  acts_as_authentic do |c|
  end
  attr_accessible :email, :password, :password_confirmation
  # attr_accessible :title, :body
end
