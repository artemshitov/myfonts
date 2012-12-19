require "httparty"
require "nokogiri"

module MyFonts
  class Model
    def initialize(url)
      @url = url
    end

    def dom
      @dom ||= get_dom(@url)
    end

    private

    def get_dom(url)
      url.sub!(/\/*$/, "/")
      myfonts_page = HTTParty.get(url)
      Nokogiri::HTML(myfonts_page.body)
    end
  end
end