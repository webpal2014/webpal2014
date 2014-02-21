class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user   # rating kuuluu myös käyttäjään

	validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  scope :recent, ->{ Rating.order(id: :desc).limit(5) }
  
  
  def self.most_active
    return User.all.sort_by{|u| -u.ratings.count}.take(3)
  end



  def to_s
    return "#{beer.name} #{score}"
  end

end
