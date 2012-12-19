require "spec_helper"
require "myfonts/model"

describe MyFonts::Model do
  it "fetches pages correctly" do
    VCR.use_cassette("MyFonts") do
      @model = MyFonts::Model.new("http://www.myfonts.com")
    end
    File.open(File.expand_path("../fixtures/myfonts.com.html", __FILE__)) { |f| @reference = f.read }
    @model.html.text.should == Nokogiri::HTML(@reference).text
  end
end