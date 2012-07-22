module WriteLocations
  def self.run!
    Activity.find_in_batches(:batch_size => 100) do |group|
      group.each do |activity|
        if activity.longitude.nil? and activity.latitude.nil?
          loc = AddressConverter::location_from_address(activity.address)
          activity.latitude, activity.longitude = loc.lat, loc.long
          activity.save
        end
      end
    end
  end
end
