class Picture < ActiveRecord::Base

  belongs_to :user, :foreign_key => :user_id
  validates :user_id, :pic,:presence => true
  attr_accessible :user_id, :album_id, :caption, :pic_file_name, :pic_content_type,:pic_file_size

  has_attached_file :pic, :styles => { :medium => "300x300>",:thumb => "160x160>" }

  validates_attachment 	:pic,
                        :presence => true,
                        :content_type => { :content_type => /\Aimage\/.*\Z/ },
                        :size => { :less_than => 5.megabyte }
end
