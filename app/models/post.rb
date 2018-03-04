class Post < ActiveRecord::Base

  #include PgSearch
  #pg_search_scope :search_title, :against => [:title]
  #multisearchable :against => [:title]
  
  
  POSTYPES = %w[attachment nav_menu_item page post article news revision]
  POSTSTATUS = %w[publish inherit draft auto-draft trash]  
  OPENCLOSESTATUS =%w[open closed]
  
  attr_accessible :author, :content, :title,:id ,:content_type,:status,:comment_status,:ping_status,:name,:visibility,:published,:pinged,:image,:tag
	
	has_attached_file :image, :url => "/:class/:attachment/:id/:style_:basename.:extension"
  validates_attachment_content_type :image, :content_type =>['image/jpeg', 'image/png', 'image/gif']
 
	belongs_to :user, :foreign_key => :author
	
	has_many :comments, :dependent => :destroy
  has_many :post_tag, :foreign_key => :post_id
  has_many :tags, :through => :post_tag
  
  
#	validates :content, :title, :author, :status ,:content_type,:published ,:presence => true
#	validates :title, :length => { :in => 3..255 }
#  validates_uniqueness_of :title
  
#  validates :content_type, :inclusion => { :in => POSTYPES }
#  validates :status, :inclusion => { :in => POSTSTATUS }
#  validates :comment_status, :ping_status, :inclusion => { :in => OPENCLOSESTATUS }

  include PgSearch
  multisearchable :against => [:title,:content,:author]

#  include PublicActivity::Model
#  tracked
  
  include AutoHtml
  
  #auto_html_for :content do
#  html_escape
#   image
#   youtube(:width => 600,:height=>400)
#   link :target => "_blank",:rel => "nofollow"
  #   simple_format
#end
 
  def self.tag_counts
    Tag.select("name.*,count(post_tags.tag_id) as count").joins(:post_tag).group("post_tags.tag_id") 
  end
  
end
