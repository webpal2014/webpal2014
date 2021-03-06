json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.brewery do
    json.beer brewery.beers.count
  end
end
