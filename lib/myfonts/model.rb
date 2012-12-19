require "httparty"
require "nokogiri"

module MyFonts
  class Model
    def initialize(url)
      @html = get_html(url)
    end

    def html
      @html
    end

    private

    def get_html(url)
      url.sub!(/\/*$/, "/")
      myfonts_page = HTTParty.get(url)
      Nokogiri::HTML(myfonts_page.body)
    end
  end
end