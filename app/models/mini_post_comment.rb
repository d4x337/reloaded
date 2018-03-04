class MiniPostComment < ActiveRecord::Base
 attr_accessible :user_id,:mini_post_id, :content, :created_at,:visibility,:likes,:dislikes
  belongs_to :mini_post
  belongs_to :user
  
  has_many :mini_post_comment_liking, :dependent => :destroy

  validates :mini_post_id    ,:presence => true
  validates :user_id     ,:presence => true
  #validates :content, :presence => true,:format => { :with => /\A[a-zA-Z0-9\s]+\z/, :message => "this comment contains invalid chars"}
  validates :content, :presence => true
  
  include AutoHtml
  
  auto_html_for :content do
    html_escape
    image
    youtube(:width => 210,:height=>130)
    link :target => "_blank",:rel => "nofollow"
    simple_format
  end
  
end