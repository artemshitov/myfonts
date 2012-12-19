require "httparty"
require "nokogiri"
require "myfonts/model"

module MyFonts
  class Designer < Model
    def name
      html.css("title").text.gsub(/ . MyFonts/, "")
    end

    def families
      result = html.css("h4 a").map do |a|
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