class Company < ActiveRecord::Base
	include Contact
	
  attr_accessible :name

  validates :name, presence: true
end
