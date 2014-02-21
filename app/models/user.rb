class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password


	validates :username, uniqueness: true,
                       length: { minimum: 3 }
	validates :password, :format => { :with => /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\d).{4,}$/,
    :message => "Pitää olla yksi iso kirjain ja numero" , :multiline => true}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs , through: :memberships
  
  def to_s
    return username
  end

   def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
	
	if(ratings.empty?)
	return nil
	end
	style = []
	index = 0
	beers.each do |b|
		if(!style.include?(b.style))
		style[index] = b.style
		index = index + 1
		end
	end

	max = 0.0	
	styler = ""
	style.each do |s|
	ma = ava(s)
	if(max < ma)
		styler = s
		max = ma
	end
	end
  return styler

  end
def favorite_brewery

	return nil if(ratings.empty?)
	
	brewery = []
	#index = 0
	beers.each do |b|
		if(!brewery.include?(b.brewery))
			brewery << b.brewery
			#index = index + 1
		end
	end

	max = 0.0	
	beerf = nil
	beers.each do |b|
		ma = ava_bre(b.brewery)
		if(max < ma)
			beerf = b.brewery
			max = ma
		end
	end

	return beerf
end

  def ava_bre(brewery)
	sum = 0.0
	count = 0.0

	ratings.each do |r| 
		if(r.beer.brewery == brewery)
			sum = sum + r.score
			count = count + 1
		end
	end
	return sum/count
  end

  def ava(style)
	sum = 0.0
	count = 0.0

	ratings.each do |r| 
	if(r.beer.style	== style)
		sum = sum + r.score
		count = count + 1
	end
	end
	return sum/count
  end

  def self.active_user

	return  User.all.sort_by{|u| -u.ratings.size}.take 3

  end




end


