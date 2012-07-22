require 'json'
require 'rest_client'

class ActivityFinder
  def location_from_address(addr)
    Location = Struct.new(:lat, :long)
    resp = RestClient.get("https://maps.googleapis.com/maps/api/geocode/json",
                          {:params => {:address => addr,
                                        :sensor => "false"}})
    results = JSON.parse(resp)["results"]
    loc = results[0]["geometry"]["location"]

    Location.new(loc["lat"], loc["lng"])
  end
end
