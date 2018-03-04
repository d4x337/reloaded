class Ad < ActiveRecord::Base
 
  validates :title,:content,:presence => true
 
  has_attached_file :image, :url => "/:class/:attachment/:id/:basename.:extension"
 
  validates_attachment_content_type :image, :content_type =>['image/jpeg', 'image/png', 'image/gif']
 
 
 # include PublicActivity::Model
 # tracked
  
 
end
