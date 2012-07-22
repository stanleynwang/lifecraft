require 'restclient'
require 'nokogiri'
require 'peach'

class Scraper::SfGate
  Scraper::SCRAPERS << self

  URL_HOST = 'http://events.sfgate.com'
  URL_BASE = "#{URL_HOST}/search"
  DEFAULT_PARAMS = {
    :new => 'n',
    :rss => 1,
    :st => 'event',
    :svt => 'text',
    :srad => 85,
    :swhat => '',
    :swhere => ''
  }

  def self.url
    URL_HOST
  end

  def initialize(date)
    @date = date
  end

  def uri(opts)
    opts.reverse_merge!(DEFAULT_PARAMS)
    url = URI(URL_BASE)
    url.query = URI.encode_www_form(opts)
    url
  end

  def date
    @date.strftime('%m/%d/%Y')
  end

  def scrape!
    url = uri(:when => self.date).to_s
    Nokogiri::XML(RestClient.get(url)).css('item').pmap do |item|
      hash = Item.new(item).to_hash
      hash[:source] = self.class
      hash
    end
  end

  class Item
    def initialize(node)
      @node = node
    end

    def title
      CGI.unescapeHTML(
        @node.css('title').first.inner_text.sub(/^Event: /, '')
      )
    end

    def description
      CGI.unescapeHTML(@node.css('description').first.inner_text)
    end

    def start_time
      DateTime.parse(
        @node.xpath('.//xCal:dtstart', @node.namespaces).first.inner_text
      )
    end

    def end_time
      dtend = @node.xpath('.//xCal:dtend', @node.namespaces).first
      return nil if not dtend
      return nil if dtend.inner_text.empty?
      DateTime.parse(dtend.inner_text)
    end

    def url
      @node.css('link').first.inner_text
    end

    def address
      parts = {}

      %w(street city region postalcode).each do |part|
        parts[:"#{part}"] = @node.xpath(
          ".//xCal:x-calconnect-#{part}", @node.namespaces
        ).first.inner_text
      end

      "#{parts[:street]}, #{parts[:city]}, #{parts[:region]} #{parts[:postalcode]}"
    end

    def lat
      @node.xpath('.//geo:lat', @node.namespaces).first.inner_text.to_f
    end

    def long
      @node.xpath('.//geo:long', @node.namespaces).first.inner_text.to_f
    end

    def to_hash
      {
        :name => title,
        :description => description,
        :url => url,
        :start_time => start_time,
        :end_time => end_time,
        :address => address,
        :latitude => lat,
        :longitude => long
      }
    end
  end
end

