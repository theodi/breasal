require 'spec_helper'

describe Breasal::EastingNorthing do

  context "When provided with a GB Easting and Northing" do
    
    it "returns the correct WGS84 latitude and longitude" do
      en = Breasal::EastingNorthing.new(easting: 412617, northing: 308885)
      
      ll = en.to_wgs84
      
      ll[:latitude].should == 52.67752501534847
      ll[:longitude].should == -1.8148108086293673
    end
    
  end
  
  context "When provided with an Irish Easting and Northing" do
    
    it "returns the correct WGS84 latitude and longitude" do
      en = Breasal::EastingNorthing.new(easting: 333832, northing: 374014, type: :ie)
      
      ll = en.to_wgs84
      
      ll[:latitude].should == 54.596642596875334
      ll[:longitude].should == -5.930070032491946
    end
    
  end
  
end
