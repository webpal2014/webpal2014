class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
  
  def show
   #@city = BeermappingApi.fetch_pubs(params[:city])
    @place = BeermappingApi.fetch_place(params[:id])
  end
end
