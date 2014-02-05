require 'spec_helper'

describe Beer do
   it "has the beer set correctly" do
    beer = Beer.new name:"Uusi1" , style:"IPA" 

    beer.name.should == "Uusi1"
    beer.style.should == "IPA"
  end

 it "is not saved without a name" do
    beer = Beer.create style:"IPA"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

 it "is not saved without a style" do
    beer = Beer.create name:"Uusi1"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
