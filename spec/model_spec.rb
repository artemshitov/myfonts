require "spec_helper"
require "myfonts/model"

describe MyFonts::Model do
  before do
    File.open(File.expand_path("../fixtures/myfonts.com.html", __FILE__)) do |f| 
      @reference = f.read
    end
    @model = MyFonts::Model.new("http://www.myfonts.com")
  end

  it "doesn't load page on model initialization" do
    WebMock.should_not have_requested(:get, "www.myfonts.com")
  end

  it "lazy loads page when dom is called" do
    stub_request(:any, "www.myfonts.com")
    @model.dom
    WebMock.should have_requested(:get, "www.myfonts.com")
  end

  it "doesn't load page when dom is called second time" do
    stub_request(:any, "www.myfonts.com")
    @model.dom
    WebMock.reset!
    @model.dom
    WebMock.should_not have_requested(:get, "www.myfonts.com")
  end

  it "fetches page correctly" do
    VCR.use_cassette("MyFonts") do
      @model.dom.text.should == Nokogiri::HTML(@reference).text
    end
  end
end