# encoding: utf-8

require 'spec_helper'
require 'myfonts/face'

describe MyFonts::Face do
  before :all do
    @face = MyFonts::Face.new("http://www.myfonts.com/fonts/letterheadrussia/21-cent/cond-ultra-light-ital/")
  end

  around do |test|
    VCR.use_cassette "21Cent-Cond-Ultra-Light-Ital" do
      test.run
    end
  end

  it "shows correct face name" do
    @face.name.should == "21 Cent Condensed Ultra Light Italic"
  end

  it "references correct family" do
    @face.family.name.should == "21 Cent"
  end
end