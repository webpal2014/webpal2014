class RatingsController < ApplicationController

  def index
	@ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    rating = Rating.create params.require(:rating).permit(:score, :beer_id)

    # talletetaan tehdyn reittauksen sessioon 
    session[:last_rating] = "#{rating.beer.name} #{rating.score} points"

    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to current_user
  end
end
