require "myfonts/model"
require "myfonts/previewable"

module MyFonts
  class Family < Model
    include Previewable

    def initialize(url, name=nil)
      @name = name
      super(url)
    end

    def name
      @name ||= get_name
    end

    def foundry
      @foundry ||= get_foundry
    end

    def faces
      @faces ||= get_faces
    end

    def designers
      @designers ||= get_designers
    end

    def design_dates
      @design_dates ||= get_design_dates
    end

    def description
      @description ||= get_description
    end

    def images
      @images ||= get_images
    end

    private

    def get_name
      dom.css("title").text.gsub(/ - (Desktop|Webfont).+/, "")
    end

    def get_foundry
      foundry_link = dom.css("ul.family_metadata li a").select{ |l| l.get_attribute("href") =~ /foundry/ }[0]
      Foundry.new(foundry_link.get_attribute("href"), foundry_link.text)
    end

    def get_faces
      links = dom.css("h4 a").select{ |l| !l.text.empty? }
      links.map do |l|
        Face.new("http://www.myfonts.com" + l.get_attribute("href"), l.text)
      end
    end

    def get_designers
      links = dom.css("ul.family_metadata li a")
      designers_links = links.select{ |l| l.get_attribute("href") =~ /person/ }
      designers_links.map do |l|
        Designer.new("http://www.myfonts.com" + l.get_attribute("href"), l.text)
      end
    end

    def get_design_dates
      li = dom.css("ul.family_metadata li")
      li = li.select { |l| l.text =~ /Design date/}
      dates = li[0].text[/(\d+(, )*)+/]
      dates.split(", ").map { |e| e.to_i }
    end

    def get_description
      dom.css(".article_tease_container").text.gsub(/(^\s+)|(\s+$)|(\t+)/, "")
    end

    def get_images
      dom.text.scan(/[\d\/]+\.png/).map { |e| "http://cdn.myfonts.net/s/aw/720x360/" + e }
    end
  end
end