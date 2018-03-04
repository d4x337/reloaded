class Contact < ActiveRecord::Base
  belongs_to :user
  validates :fullname,:email,:presence => true
  validates :fullname, :length => { :in => 3..255 }
  
  has_attached_file :picture, :styles => { :large => "300x300>",:thumb => "100x100>" }, :processors => [:cropper]
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  validates_attachment  :picture, :presence => true, :content_type => { :content_type => /\Aimage\/.*\Z/ }, :size => { :less_than => 3.megabyte }
  attr_accessible :user_id,  :crop_x, :crop_y, :crop_w, :crop_h,:fullname, :address,:city, :company, :headline, :country,:state, :postal_code, :email, :mobile, :gender, :birthdate, :picture
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(picture.path(style))
  end
  
  
end
