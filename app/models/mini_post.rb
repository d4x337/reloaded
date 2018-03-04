class MiniPost < ActiveRecord::Base
 
  VISIBILITY = %w[FRIEND CLOSE_FRIEND PUBLIC CUSTOM ACQUAINTANCE COLLEGUE PARENT]

  attr_accessible :id,:author_id, :content, :created_at,:visibility,:likes,:dislikes,:image
  belongs_to :user, :foreign_key => :author_id
  
  has_many :mini_post_tag, :foreign_key => :mini_post_id
  has_many :tag, :through => :mini_post_tag
  has_many :mini_post_comment, :dependent => :destroy
  has_many :mini_post_liking,:foreign_key => :mini_post_id, :dependent => :destroy
  has_many :mini_post_favorite,:foreign_key => :mini_post_id, :dependent => :destroy
  has_many :mini_post_feed,:class_name=>"MiniPostFeed",:foreign_key => :mini_post_id
  has_attached_file :image, :url => "/:class/:attachment/:id/:style_:basename.:extension"
 
  validates :author_id, :presence => true

  validates :content, :presence => true,:format => { :with => /\A[a-zA-Z0-9\s\W]+\z/, :message => "this post contains invalid chars"}
  validates :content, :presence => true
  validates_attachment_content_type :image, :content_type =>['image/jpeg', 'image/png', 'image/gif', 'video/quicktime', 'video/avi', 'video/mpeg']

  include AutoHtml

  auto_html_for :content do
    html_escape
    image
    youtube(:height=>170,:width=>280)
    #youtube(:class=>"YTT")
    link :target => "_blank",:rel => "nofollow"
    simple_format
  end

  def self.feed(last,userid)
    @user = User.find(userid)
     self.where('author_id in (?) and created_at < ?',@user.friends.map(&:friend_id).push(@user.id),last).limit(5).order(:created_at).reverse_order
  end
  
  def self.feed_owns(last,userid)
    @user = User.find(userid)
     self.where('author_id = ? and created_at < ?',@user.id,last).order(:created_at).limit(5)
  end

  def timestamp
    created_at.strftime('%d %B %Y %H:%M:%S')
  end

  def d4xValidator
    if self.image.present? and !self.content.present?
      return true
    elsif !self.image.present? and self.content.present?
      return true
    elsif self.image.present? and self.content.present?
      return true
    else
      return false
    end

  end

end
