class User < ActiveRecord::Base
	include RatingAverage

  	has_many :ratings   # käyttäjällä on monta ratingia
end
