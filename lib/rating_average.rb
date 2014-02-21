
module RatingAverage

	def average_rating
	if(ratings.count == 0)
		return 0
	end
		return ratings.average('score')

	end
end

