class Upload < ActiveRecord::Base
 
  has_attached_file :image#, :styles => { :medium => "300x300>",:thumb => "100x100>" }
  do_not_validate_attachment_file_type :image
 # validates_attachment  :image, :presence => true, :content_type => { :content_type => /\Aimage\/.*\Z/ }, :size => { :less_than => 10.megabyte }
  attr_accessible :image
 
  attr_accessible :user_id,:encoded_filename,:filepath,:encoded_size,:compressed,:key,:entropy,:image,:image_file_name,:is_encrypted
  belongs_to :user,:foreign_key=>:user_id
  
  attr_encrypted :key, :key => 'a secret key', :mode => :per_attribute_iv_and_salt, :algorithm => 'bf'
  attr_encrypted :entropy, :key => 'another secret key', :mode => :per_attribute_iv_and_salt, :algorithm => 'bf'

  
 # after_create :do_encrypt
      
    def do_encrypt
      cipher = OpenSSL::Cipher.new('aes-256-cbc')
      cipher.encrypt
      self.key = cipher.random_key
      self.entropy  = cipher.random_iv
      self.encoded_filename = self.image.path+".enc" 
      self.save!
      buf = ""
      File.open(self.encoded_filename, "wb") do |outf|
        File.open(self.image.path, "rb") do |inf|
          while inf.read(4096, buf)
            outf << cipher.update(buf)
          end
          outf << cipher.final
        end
      end
      if File.exist? self.encoded_filename
        self.image.destroy
      end
      #do_decrypt
    end
      
    def do_decrypt
      cipher = OpenSSL::Cipher.new('aes-256-cbc')
      cipher.decrypt
      cipher.key = self.key
      cipher.iv  = self.entropy
      buf = ""
      image_filename = self.encoded_filename[0..self.encoded_filename.length-5]
      File.open(image_filename, "wb") do |outf|
        File.open(self.encoded_filename, "rb") do |inf|
          while inf.read(4096, buf)
            outf << cipher.update(buf)
          end
          outf << cipher.final
        end
      end
    end
    
end
