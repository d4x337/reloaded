class Ad < ActiveRecord::Base
 
  validates :title,:content,:presence => true
  has_attached_file :image, :url => "/:class/:attachment/:id/:basename.:extension"
  validates_attachment_content_type :image, :content_type =>['image/jpeg', 'image/png', 'image/gif']
  attr_accessible :title, :content, :url, :action, :active, :expire_at, :customer_id, :image_file_name, :image_content_type,:image_file_size,:type, :locale, :viewed, :visibility
end
