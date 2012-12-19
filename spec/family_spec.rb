# encoding: utf-8

require 'spec_helper'
require 'myfonts/family'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe Myfonts::Family do
  before do
    VCR.use_cassette('21Cent') do
      @myfonts = Myfonts::Family.new("http://www.myfonts.com/fonts/letterheadrussia/21-cent/")
    end
  end

  it "returns correct foundry name" do
    @myfonts.foundry.should == "Letterhead Studio-YG"
  end

  it "returns correct designers list" do
    @myfonts.designers.should == ["Yuri Gordon"]
  end

  it "returns correct list of faces" do
    result = @myfonts.faces
    expected = {name: "21 Cent Condensed-Italic", path: "cond-ital"}
    result.should include expected
    result.size.should == 10
  end

  it "returns correct design dates" do
    @myfonts.design_dates.should == [2008, 2010]
  end

  it "returns correct description" do
    @myfonts.description.should include "21 Cent - not Century or Clarendon."
  end

  it "returns correct list of images" do
    i = @myfonts.images
    i.should include "http://cdn.myfonts.net/s/aw/720x360/99/0/50813.png"
    i.size.should == 8
  end
end