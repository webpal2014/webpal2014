require 'spec_helper'

include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "7" do
  user1 = FactoryGirl.create(:user, username: "user1")
  user2 = FactoryGirl.create(:user, username: "user2")
   
 visit user_path(user1)
  
    expect(page).to have_content "beer has not yet been rated!"
    
    rating_c2(user2,user1)

    visit user_path(user1)
    Rating.all.each do |r|
	if(user1 == r.user) 
	expect(page).to have_content(r.beer.name + " " + r.score.to_s)
	else
	expect(page).to have_no_content(r.beer.name + " " + r.score.to_s)
	end
    end

  end
 
 it "8" do

  user1 = FactoryGirl.create(:user, username: "user1")
  user2 = FactoryGirl.create(:user, username: "user2")

  rating_c2(user2,user1)
  rating_count = Rating.all.count
  sign_in(username:"user1", password:"Foobar1")
  visit user_path(user1)
  first('li').click_link('delete')
  expect(Rating.all.count).to eq(rating_count-1)
  
 end


end

def rating_c2(user2,user1) 

  beer1 = FactoryGirl.create(:beer, name:"iso 3")
  beer2 = FactoryGirl.create(:beer, name:"Karhu")

  FactoryGirl.create(:rating, score: 23,  beer: beer1, user: user2)
  FactoryGirl.create(:rating, score: 33,  beer: beer2, user: user2)

  FactoryGirl.create(:rating, score: 11,  beer: beer1, user: user1)
  FactoryGirl.create(:rating, score: 23,  beer: beer2, user: user1)
  FactoryGirl.create(:rating, score: 44,  beer: beer1, user: user1)
end
