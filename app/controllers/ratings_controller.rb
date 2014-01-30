class RatingsController < ApplicationController

  def index
	@ratings = Rating.all
  end
  def show
  <ul>
    <% @user.ratings.each do |rating| %>
      <li> 
        <%= rating %> 
        <% if @user == current_user %>
            <%= link_to 'delete', rating, method: :delete, data: { confirm: 'Are you sure?' } %> 
        <% end %>
      </li>
    <% end %>
  </ul>
end
  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end
