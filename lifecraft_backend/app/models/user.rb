# User
# email:string
# password:string (NOT USED!!!)
# level:integer
# experience:integer
class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_many :quests
  belongs_to :current_quest, :class_name => "Quest"
  before_save :level_up

  acts_as_authentic do |c|
  end

  # def by_completed(role) #great for returning all of the users whose role is FRIEND
  #   find(:all, :conditions => ["quests.completed = ?", role])
  # end

  after_validation :log_errors, :if => Proc.new {|m| m.errors}

  def log_errors
    Rails.logger.debug self.errors.full_messages.join("\n")
  end

  def level_up
    return unless can_level_up?
    return if self.level.nil?

    self.level = LevelManager::new_level(self.level, self.experience)
  end

  def can_level_up?
    self.experience >= LevelManager::required_exp(self.level + 1)
  end

  def to_json(options = {})
    {
      :id => self.id,
      :email => self.email,
      :experience => self.experience,
      :level => self.level
    }.to_json
  end

  # attr_accessible :title, :body
end
