class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city) { fetch_places_in(city) }
  end

  private

  def self.fetch_places_in(city)
     #url = "http://beermapping.com/webservice/loccity/#{key}/"
     url = "http://stark-oasis-9187.herokuapp.com/api/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    Settings.beermapping_apikey
  end

  def self.fetch_pubs(city)
	Rails.cache.read(city)
  end

  def self.fetch_place(id)
      url = "http://beermapping.com/webservice/locquery/#{key}/"

	#url = "http://stark-oasis-9187.herokuapp.com/api/"

    response = HTTParty.get "#{url}#{id.to_s}"
    place = response.parsed_response["bmp_locations"]["location"]

   return nil if place.is_a?(Hash) && place["id"] == nil
   return Place.new(place)
  end

end
