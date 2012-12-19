require "myfonts/model"

module MyFonts
  class Face < Model
    def initialize(url, name=nil)
      @name = name
      super(url)
    end

    def name
      @name ||= get_name
    end

    def family
      @family ||= get_family
    end

    private

    def get_name
      dom.css("h1 img")[0].get_attribute("title")
    end

    def get_family
      a = dom.css("#headcrumbs li")[-2].css("a")[0]
      Family.new("http://www.myfonts.com" + a.get_attribute("href"), a.text)
    end
  end
end