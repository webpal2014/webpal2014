require 'spec_helper'
describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a password in number" do
    user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a password is over 4 char" do
    user = User.create username:"Pekka", password:"Se1", password_confirmation:"Se1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end

  end

 describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

describe "3" do
  let(:user){FactoryGirl.create(:user) }
  it "3.1" do
	user.should respond_to :favorite_style
  end

  it "3.2" do
	expect(user.favorite_style).to eq(nil)
  end 

  it "3.3" do
	style_rating(10 , user, "koe")

	expect(user.favorite_style).to eq("koe")

  end

    it "3.4" do
	style_rating(10 , user, "koe")
	style_rating(40 , user, "koe")
	style_rating(20 , user, "koe1")
	expect(user.favorite_style).to eq("koe")

  end

  it "4.1" do
	 user.should respond_to :favorite_brewery
  end
 
  it "4.2" do
	expect(user.favorite_brewery).to eq(nil)
  end 
  
  it "4.3" do
	b = brewery_rating(10,  user, "Uusi")
	expect(user.favorite_brewery).to eq(b)
  end

  it "4.4" do
	b = brewery_rating(10,  user, "Uusi")
	brewery_rating(10,  user, "Uusi")
	brewery_rating(10,  user, "Uusi")
	brewery_rating(10,  user, "Uusi2")
	expect(user.favorite_brewery).to eq(b)
  end
end
  

end # describe User

def style_rating(score,  user, style)

  beer = FactoryGirl.create(:beer, style: style)
  FactoryGirl.create(:rating, score: score,  beer: beer, user: user)

end 

def brewery_rating(score,  user, brewery_name)

    brewery = FactoryGirl.create(:brewery, name: brewery_name)
    beer = FactoryGirl.create(:beer, brewery: brewery)
    FactoryGirl.create(:rating, score: score,  beer: beer, user: user)
    return brewery
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating score, user
  end
end

def create_beer_with_rating(score,  user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end  
