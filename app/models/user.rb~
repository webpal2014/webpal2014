class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password

	validates :username, uniqueness: true,
                       length: { minimum: 3 }
	validates :password, :format => { :with => /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\d).{4,}$/,
    :message => "Pitää olla yksi iso kirjain ja numero" , :multiline => true}

  has_many :ratings
  has_many :beers, through: :ratings

  has_many :memberships
  has_many :beer_clubs , through: :memberships
  
  def to_s
    return name
  end
end
