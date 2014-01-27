class Brewery < ActiveRecord::Base
  include RatingAverage

		validates :name, presence: true 
		validates :year,numericality: { greater_than_or_equal_to: 1042,
                                    only_integer: true }

		#validates_with GoodnessValidator

  has_many :beers
  has_many :ratings, through: :beers



end

class GoodnessValidator < ActiveModel::Validator
	def validate(record)
	if(Date.today.year > year)
	record.errors[:year] << "Error"
	end
end
end
