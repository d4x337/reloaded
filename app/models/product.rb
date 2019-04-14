class Product < ActiveRecord::Base

# belongs_to :category
  has_many :cart_products

  attr_accessible :name, :description, :summary, :final_price, :costs, :category, :currency, :quota, :subscription, :pay_once, :in_stock, :promo, :active, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at


  PRODUCTYPES = %w[service product]
  PAYMENTS = %w[single free unatantum annual]
  validates :name,:category,:final_price,:presence => true
  validates :name, :length => { :in => 3..255 }
  validates_uniqueness_of :name
  validates :category, :inclusion => { :in => PRODUCTYPES }
  validates :subscription, :inclusion => { :in => PAYMENTS }
 
  has_attached_file :photo,:convert_options=>{:thumb=> "-crop 90x90+40+30"},:url => "/:class/:basename.:extension"
  validates_attachment_content_type :photo, :content_type =>['image/jpeg', 'image/png', 'image/gif']

  include PgSearch
  multisearchable :against => [:name,:description,:summary]

end
