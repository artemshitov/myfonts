# encoding: utf-8

require "myfonts/foundry"
require "spec_helper"

describe MyFonts::Foundry do
  before :all do
    @foundry = MyFonts::Foundry.new("http://www.myfonts.com/foundry/LHS-YG/")
  end

  around do |test|
    VCR.use_cassette("Letterhead") do
      test.run
    end
  end

  it "returns correct foundry name" do
    @foundry.name.should == "Letterhead Studio-YG"
  end

  it "returns foundry type families" do
    @foundry.families.size.should == 15
    @foundry.families[0].name.should == "Conqueror Sans™"
  end
end