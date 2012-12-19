require "httparty"
require "nokogiri"
require "myfonts/model"

module MyFonts
  class Designer < Model
    def initialize(url, name=nil)
      @name = name
      super(url)
    end

    def name
      @name ||= get_name
    end

    def families
      @families ||= get_families
    end

    private

    def get_name
      dom.css("title").text.gsub(/ . MyFonts/, "")
    end

    def get_families
      result = dom.css("h4 a").map do |a|
        if a.get_attribute("href") =~ /^\/fonts/
          a.text
        else
          nil
        end
      end
      result.compact
    end

  end

end