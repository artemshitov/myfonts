require "myfonts/model"

module MyFonts
  class Foundry < Model
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
      result = dom.css("h4 a").select do |a|
        a.get_attribute("href") =~ /^\/fonts/
      end
      result.map do |a|
        Family.new("http://www.myfonts.com" + a.get_attribute("href"), a.text)
      end
    end
  end
end