class BeerClub < ActiveRecord::Base


has_many :memberships 
has_many :users, through: :memberships



  def to_s
    return name
  end

end
