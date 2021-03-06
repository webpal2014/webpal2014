require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }


  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "6" do

  rating_c
  visit ratings_path
  expect(page).to have_content "Number of ratings "+ Rating.all.count

    Rating.all.each do |r| 
	expect(page).to have_content(r.beer.name + " " + r.score.to_s)
    end
  end




end

def rating_c 
  FactoryGirl.create(:rating, score: 23,  beer: beer1, user: user)
  FactoryGirl.create(:rating, score: 33,  beer: beer2, user: user)
  FactoryGirl.create(:rating, score: 11,  beer: beer1, user: user)
  FactoryGirl.create(:rating, score: 23,  beer: beer2, user: user)
  FactoryGirl.create(:rating, score: 44,  beer: beer1, user: user)
end
