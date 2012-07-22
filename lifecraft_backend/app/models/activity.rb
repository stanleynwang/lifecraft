# Activity
# url:string
# name:string
# description:text
# address:text
# latitude:float
# longitude:float
# start_time:datetime
# end_time:datetime
class Activity < ActiveRecord::Base
  attr_accessible :name, :description, :url, :start_time, :end_time, :address,
                  :latitude, :longitude
end
