class Beer < ActiveRecord::Base
	include RatingAverage
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings
  has_many :raters, -> { uniq }, through: :ratings, source: :user

		validates :name, presence: true
 		validates :style, presence: true
 		validates :brewery, presence: true

	def to_s
		return name + ' ' +brewery.name  
	end

  def self.average
    return Beer.all.sort_by{|b| -b.average_rating}.take(3)
  end



end
