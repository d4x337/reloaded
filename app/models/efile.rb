class Efile < ActiveRecord::Base
   
    attr_encrypted :key, :key => 'asdfbadf345t2346tdfz542tyg32u4ib51235', :mode => :per_attribute_iv_and_salt, :algorithm => 'bf'
    attr_encrypted :entropy, :key => 'KJN43UIRBN34980H423983UFDFBSENUJKFjesdkbfsau', :mode => :per_attribute_iv_and_salt, :algorithm => 'bf'
    has_attached_file :original
    attr_accessible :user_id,:encoded_filename,:filepath,:encoded_size,:compressed,:key,:entropy,:original,:original_file_name
    # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    belongs_to :user,:foreign_key=>:user_id
    belongs_to :message,:foreign_key=>:message_id
     
    validates_attachment_size :original, :less_than => 100.megabytes
    validates_attachment_presence :original
    do_not_validate_attachment_file_type :original
  
    after_create :do_encrypt
  
    def do_encrypt
      cipher = OpenSSL::Cipher.new('aes-256-cbc')
      cipher.encrypt
      self.key = cipher.random_key
      self.entropy  = cipher.random_iv
      self.encoded_filename = self.original.path+".enc" 
      self.save!
      buf = ""
      File.open(self.encoded_filename, "wb") do |outf|
        File.open(self.original.path, "rb") do |inf|
          while inf.read(4096, buf)
            outf << cipher.update(buf)
          end
          outf << cipher.final
        end
      end
      if File.exist? self.encoded_filename
        self.original.destroy
      end
      #do_decrypt
    end
      
    def do_decrypt
      cipher = OpenSSL::Cipher.new('aes-256-cbc')
      cipher.decrypt
      cipher.key = self.key
      cipher.iv  = self.entropy
      buf = ""
      original_filename = self.encoded_filename[0..self.encoded_filename.length-5]
      File.open(original_filename, "wb") do |outf|
        File.open(self.encoded_filename, "rb") do |inf|
          while inf.read(4096, buf)
            outf << cipher.update(buf)
          end
          outf << cipher.final
        end
      end
    end

end
