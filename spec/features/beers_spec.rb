require 'spec_helper'
include OwnTestHelper

describe "Beer" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }


  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
end

  it "new beer" do
    visit new_beer_path
    select('Weizen', from:'beer_style')
    select('Koff', from:'beer[brewery_id]')
    fill_in('beer_name', with:'Olut1')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end

  it "new beer_error" do
    visit new_beer_path
    select('Weizen', from:'beer_style')
    select('Koff', from:'beer[brewery_id]')
    fill_in('beer_name', with:'')

    click_button "Create Beer"

    expect(page).to have_content "Name can't be blank"

  end
end
