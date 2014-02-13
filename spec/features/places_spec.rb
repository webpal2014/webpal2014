require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if many is returned by the API, it every shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi"),Place.new(:name => "uusipaikka") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "uusipaikka"
  end
  it "if 0 is returned by the API, it shown at the page No locations in" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in"
  end
end
