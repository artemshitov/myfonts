# encoding: utf-8

require 'spec_helper'
require 'myfonts/designer'

describe MyFonts::Designer do
  before do
    VCR.use_cassette('YuriGordon') do
      @designer = MyFonts::Designer.new("http://www.myfonts.com/person/yuri-gordon/")
    end
  end

  it "returns correct designer name" do
    @designer.name.should == "Yuri Gordon"
  end

  it "returns designer's type families" do
    @designer.families.size.should == 14
    @designer.families.should include "Costa Dorada"
  end
end