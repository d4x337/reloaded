class Country < ActiveRecord::Base
  validates :country_code,:country_name,:presence => true
  attr_accessible :country_code,:country_name
end
