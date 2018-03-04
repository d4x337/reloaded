class Feed < ActiveRecord::Base
  
    validates :feedtag,:feedtext,:locale, :presence => true
    has_attached_file :feedicon,:url => "/:class/:attachment/:id/:basename.:extension"
    validates_attachment_content_type :feedicon, :content_type =>['image/jpeg', 'image/png', 'image/gif']
    attr_accessible :feedtag,:feedtext, :locale
 
end
