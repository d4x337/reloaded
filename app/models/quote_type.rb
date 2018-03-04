class QuoteType < ActiveRecord::Base
  
  attr_accessible :type_of_quote,:visible
  validates :type_of_quote, :presence => true;
  validates_uniqueness_of :type_of_quote;
  
 # include PublicActivity::Model
 # tracked
  
end
