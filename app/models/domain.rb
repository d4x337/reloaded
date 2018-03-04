class Domain < ActiveRecord::Base
  
  validates :domain,:vmaildir,:presence => true
  validates_uniqueness_of :domain
  attr_accessible :domain,:vmaildir,:homedir,:active,:description
 
end
