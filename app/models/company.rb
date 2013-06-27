class Company < ActiveRecord::Base
	include Contact
	
  attr_accessible :name, :user_id

  validates :name, presence: true

  belongs_to :user

  def to_s
  	"#{name}"
  end
end
