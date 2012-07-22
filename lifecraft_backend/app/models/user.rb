class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  acts_as_authentic do |c|
  end

  after_validation :log_errors, :if => Proc.new {|m| m.errors}

  def log_errors
    Rails.logger.debug self.errors.full_messages.join("\n")
  end

  # attr_accessible :title, :body
end
