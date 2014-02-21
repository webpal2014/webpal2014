class Style < ActiveRecord::Base
has_many :beers

	def to_s
		return name
	end

  def self.average
    return Style.all.sort_by{ |s| -s.beers.size}.take(3)

  end
  
  def average_rating
	return beers.size
  end

end
