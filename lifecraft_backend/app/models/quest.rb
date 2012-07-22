class Quest < ActiveRecord::Base
  belongs_to :user
  # has_one :user
  belongs_to :activity
end
