class Option < ActiveRecord::Base
  
  validates :name,:value,:presence => true
  validates :name, :length => { :in => 3..255 }
  validates_uniqueness_of :name
  attr_accessible :name,:value


end

