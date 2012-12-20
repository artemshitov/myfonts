# encoding: utf-8

require 'spec_helper'
require 'myfonts/family'

describe MyFonts::Family do
  before :all do
    @family = MyFonts::Family.new("http://www.myfonts.com/fonts/letterheadrussia/21-cent/")
  end

  around :each do |test|
    VCR.use_cassette('21Cent') do
      test.run
    end
  end

  it "returns correct foundry" do
    @family.foundry.name.should == "Letterhead Studio-YG"
  end

  it "returns correct designers list" do
    @family.designers.size.should == 1
    @family.designers[0].name.should == "Yuri Gordon"
  end

  it "returns correct list of faces" do
    @family.faces.size.should == 10
    @family.faces[0].name.should == "21 Cent Thin"
  end

  it "returns correct design dates" do
    @family.design_dates.should == [2008, 2010]
  end

  it "returns correct description" do
    @family.description.should include "21 Cent - not Century or Clarendon."
  end

  it "returns correct list of images" do
    i = @family.images
    i.should include "http://cdn.myfonts.net/s/aw/720x360/99/0/50813.png"
    i.size.should == 8
  end

  it "returns correct preview image url" do
    VCR.use_cassette "TestDrive-Family" do
      @family.preview.should =~ /http:\/\/origin\.myfonts\.net/
    end
  end
end