class Author < ActiveRecord::Base
  
  attr_accessible :fullname,:headline,:country,:photo,:presence,:dates,:notes
  has_many :quotes
  
  has_attached_file :photo, :url => "/:class/:basename.:extension", :processors => [:cropper],
    :styles => { :medium => "300x300>", :thumb => "100x100>",:icon => "48x48>" }, :default_url => "/images/:style/missing_avatar.png"


  validates_attachment_content_type :photo, :content_type =>['image/jpeg', 'image/png', 'image/gif']
  
  
  validates :fullname  ,:presence => true
  validates_uniqueness_of :fullname
  
  
  include PgSearch
  multisearchable :against => [:fullname,:headline,:dates,:country]
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?
  
  def cropping?
    #!crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry()
    @geometry ||= {}
    @geometry[] ||= Paperclip::Geometry.from_file(photo.path())
  end
  
  private
  
  def reprocess_avatar
    photo.reprocess!
  end
  
end
