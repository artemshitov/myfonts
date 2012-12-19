# encoding: utf-8

require 'spec_helper'
require 'myfonts/family'

describe MyFonts::Family do
  before :all do
    @myfonts = MyFonts::Family.new("http://www.myfonts.com/fonts/letterheadrussia/21-cent/")
  end

  around :each do |test|
    VCR.use_cassette('21Cent') do
      test.run
    end
  end

  it "returns correct foundry name" do
    @myfonts.foundry.should == "Letterhead Studio-YG"
  end

  it "returns correct designers list" do
    @myfonts.designers.size.should == 1
    @myfonts.designers[0].name.should == "Yuri Gordon"
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