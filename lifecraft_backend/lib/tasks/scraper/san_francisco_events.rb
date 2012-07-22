require 'mechanize'
require 'peach'
require 'cgi'

class Scraper::SanFranciscoEvents
  Scraper::SCRAPERS << self

  URL_HOST = 'http://www.sanfrancisco.travel'
  URL_BASE = "#{URL_HOST}/events/"
  DEFAULT_PARAMS = {
    :result => 'yes',
    :cat => '',
    :sid => 1,
    :where => 'san francisco, ca'
  }

  def self.url
    URL_HOST
  end

  def initialize(date)
    @date = date
    @bot = Mechanize.new
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
    date = "#{self.date} to #{self.date}"
    url = uri(:when => date)

    first_page = @bot.get(url)
    rest_pages = first_page.links_with(:href => %r{^/events.+pid=\d+}).map { |l|
      l.click
    }

    pages = [first_page, *rest_pages].pmap { |doc| Page.new(doc, self.class).entries }
    pages.flatten!
    pages
  end

  class Page
    def initialize(page, source)
      @page = page
      @source = source
    end

    def entries
      links = @page.links_with(:href => %r{^/events\?zventId=})
      links.uniq! { |x| x.href }
      links.pmap do |x|
        event_page = x.click
        link = event_page.link_with(:text => 'Link', :href => %r{^http://www.zvents.com})
        hash = Entry.new(link.click, link.href).to_hash
        hash[:source] = @source
        hash
      end
    end
  end

  class Entry
    def initialize(page, url)
      @page = page
      @url = url
    end

    def title
      @page.search('h1.name span.summary').first.inner_text
    end

    def start_time
      DateTime.parse(@page.search('.dtstart').first['title'])
    end

    def end_time
      e = @page.search('.dtend').first
      e ? DateTime.parse(e['title']) : e
    end

    def description
      desc = @page.search('.description p').first
      return nil if not desc
      spans = desc.css('span')

      if spans.size == 0
        CGI.unescapeHTML(desc.inner_text)
      else
        CGI.unescapeHTML(spans[0].inner_text.strip + spans[-2].inner_text.strip)
      end
    end

    def address
      addr = @page.search('#event_map_address').first
      parts = {}

      %w(street-address locality region postal-code).each do |part|
        parts[part] = addr.css(".#{part}").first.inner_text
      end

      "#{parts['street-address']}, #{parts['locality']}, #{parts['region']} #{parts['postal-code']}"
    end

    def to_hash
      {
        :title => title,
        :description => description,
        :start_time => start_time,
        :end_time => end_time,
        :address => address,
        :url => @url
      }
    end
  end
end

