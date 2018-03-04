class Link < ActiveRecord::Base
  
  #before_save :clean_html
  
  LINKTARGETS = %w[_blank _window _parent _self]  
  
  belongs_to :user, :foreign_key => :shared_by
  
	validates :url, :name ,:presence => true
	validates :name,:url, :length => { :minimum => 3 }
 	
 	validates_uniqueness_of :url
 	validates_uniqueness_of :name
 	
  
 	has_attached_file :image, :url => "/:class/:attachment/:basename.:extension"
 	
 	#ajaxful_rateable :stars =>5
 # include PublicActivity::Model
 #	tracked
 	
  include PgSearch
  multisearchable :against => [:name,:description]

  
 	def CheckLink
 	  #open the link and see if get a 200 or a 404,500 etc then t or f
 	end
 	
 	private
  def clean_html
    self.html = Sanitize.clean(html, whitelist)
  end
  
  def whitelist
    whitelist = Sanitize::Config::BASIC
    whitelist[:elements].push("span")
    whitelist[:attributes]["span"] = ["style"]
    whitelist
  end
end
