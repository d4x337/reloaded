class Group < ActiveRecord::Base
  
    attr_accessible :user_id,:title,:headline,:description,:motto,:founder,:members,:admins,:visibility,:creation_date,:mission, :deleted,:image_file_name,:image_content_type,:image_file_size,:cover_file_name,:cover_content_type,:cover_file_size
    
    GROUP_TYPES = %w[PUBLIC CLOSED SECRET]
    belongs_to :user
  
    has_many :group_members, :class_name => 'GroupMember', :foreign_key => :group_id
    
    validates :title, :headline, :description, :presence => true
    validates :visibility, :inclusion => { :in => GROUP_TYPES }
    validates_uniqueness_of :title
    has_attached_file :image, :url => "/:class/:basename.:extension"
    has_attached_file :cover, :url => "/:class/:basename.:extension"
    
    validates_attachment_content_type :image, :content_type =>['image/jpeg', 'image/png', 'image/gif']
    validates_attachment_content_type :cover, :content_type =>['image/jpeg', 'image/png', 'image/gif']
  
 
    include PgSearch
    multisearchable :against => [:title,:headline,:founder]

end
