require "httparty"
require "nokogiri"
require "myfonts/model"

module MyFonts
  class Family < Model
    def name
      html.css("title").text.gsub(/ - (Desktop|Webfont).+/, "")
    end

    def foundry
      links = html.css("ul.family_metadata li a")
      links.select{ |l| l.get_attribute("href") =~ /foundry/ }[0].text
    end

    def designers
      links = html.css("ul.family_metadata li a")
      designers_links = links.select{ |l| l.get_attribute("href") =~ /person/ }
      designers_links.map do |l|
        l.text
      end
    end

    def faces
      links = html.css("h4 a").select{ |l| !l.text.empty? }
      links.map do |l|
        {name: l.text, path: l.get_attribute("href")[/([\w-]+)\/$/, 1]}
      end
    end

    def design_dates
      li = html.css("ul.family_metadata li")
      li = li.select { |l| l.text =~ /Design date/}
      dates = li[0].text[/(\d+(, )*)+/]
      dates.split(", ").map { |e| e.to_i }
    end

    def description
      html.css(".article_tease_container").text.gsub(/(^\s+)|(\s+$)|(\t+)/, "")
    end

    def images
      html.text.scan(/[\d\/]+\.png/).map { |e| "http://cdn.myfonts.net/s/aw/720x360/" + e }
    end    
  end
end