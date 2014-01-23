class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating
		return ratings.average('score')
		#a=0.0
		#ratings.each do |r|
		#a = a+r.score
		#end 
		#return a/ratings.length
	end
end
