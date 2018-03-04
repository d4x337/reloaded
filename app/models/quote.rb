class Quote < ActiveRecord::Base

	validates :qtext,:lang, :presence => true;
	validates_uniqueness_of :qtext;
	belongs_to :author, :foreign_key => :author_id
	
	include PgSearch
  multisearchable :against => [:qtext]
 # ajaxful_rateable :stars =>10
  
	def QOTD(locale)
	  if locale.blank?
	     locale == "en"
	  end
	
	  @qotd = Quote.where(:conditions => ["last_seen = ?", Today,"and lang = ?",:lang => locale])
  
    if @qotd.blank?
       @qotd  =  Quote.where(:visible=>true,:approved=>true,:last_seen => 30.days.ago,:lang=>locale).first(:order=>"RANDOM()") 
       @qotd.first.update_attributes(:last_seen=>Time.now)
    end
    if not @qotd.blank? 
       choosen = @qotd.id
    end
    return choosen 
	end
	
end
