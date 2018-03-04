class Picture < ActiveRecord::Base

  belongs_to :user, :foreign_key => :user_id
  validates :user_id, :pic,:presence => true

  #has_attached_file :pic, :url => "/:class/:attachment/:id/:style_:basename.:extension"
  has_attached_file :pic, :styles => { :medium => "300x300>",:thumb => "100x100>" }

  validates_attachment 	:pic,
                        :presence => true,
                        :content_type => { :content_type => /\Aimage\/.*\Z/ },
                        :size => { :less_than => 1.megabyte }
end
