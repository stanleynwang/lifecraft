
module Scraper
  SCRAPERS = []

  def self.activity_for_day(date)
    result = []

    SCRAPERS.each do |scraper|
      scraper = scraper.new(date)
      result.push(*scraper.scrape!)
    end

    result
  end
end

require 'scraper/san_francisco_events'

