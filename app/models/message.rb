class Message < ActiveRecord::Base
 
   attr_accessible :sender_name, :sender_number, :sender_email, :target_name,:target_number, :target_email,:sender_id,:target_id,
    :notify_link, :read_token, :content, :sha512, :encoded, :decoded, :public_key, :cipher, :private_key, :delivered, :read, :autodestroy,:efiles,:enc_shared

   after_create :secure_message,:generate_read_token,:notify_link
   
   belongs_to :user, :foreign_key=>:sender_id
   has_one  :target, :class_name=>"User"
   has_one  :sender, :foreign_key=>:user_id
   has_many :efiles,:foreign_key=>:message_id
   accepts_nested_attributes_for :efiles, :reject_if => :all_blank, :allow_destroy => true
  
#  validates_format_of :content, :with =>/\A[\x00-\x7F]+\z/,:message => 'special chars are not allowed',:allow_blank => false
    
   def secure_message
     aes_key         = Reloaded::Application.config.default_key_aes
     twofish_key     = Reloaded::Application.config.default_key_twofish
     twofish_entropy = Reloaded::Application.config.vector_init_twofish
     blowfish_key    = Devise.secret_key
     
    # round0 = rsa_encrypt
    # round1 = aes_encrypt(round0,aes_key)
     round0 = self.content
     round1 = aes_encrypt(round0,aes_key)
     round3 = twofish_encrypt(round1,twofish_key,twofish_entropy)
     round4 = blowfish_encrypt(round3,blowfish_key)
      
     if self.enc_shared.present? 
        round5 = encrypt_with_shared_passphrase(round4,self.enc_shared)
        self.encoded = round5
        self.content = ""
        self.secured = true
        self.save!
        return round5
     else
        self.encoded = round4
        self.content = ""
        self.secured = true
        self.save!
        return round4
     end
   end
   
   def reveal_message
     round4 = blowfish_decrypt(self.encoded, Devise.secret_key)
     round3 = twofish_decrypt(round4,Reloaded::Application.config.default_key_twofish,Reloaded::Application.config.vector_init_twofish)
     round1 = aes_decrypt(round3,Reloaded::Application.config.default_key_aes)
    # round0 = rsa_decrypt(round1)
    # self.decoded = round0
    # return round0
     self.decoded = round1
     return round1
   end
   
   def encrypt_with_shared_passphrase(content,passphrase)
     passphrase = Gibberish::SHA512(passphrase)
     cipher  = Gibberish::AES.new(passphrase)
     encoded = cipher.encrypt(content)
     return encoded
   end 
   
   def decrypt_with_shared_passphrase(encoded,passphrase)
     passphrase     = Gibberish::SHA512(passphrase)
     cipher  = Gibberish::AES.new(passphrase)
     decoded = cipher.decrypt(encontent)
     return decoded
   end 
   
   #Twofish   
   def twofish_encrypt(content,key,vector_init)
     require 'twofish'
     key   = Reloaded::Application.config.default_key_twofish if key.nil?
     tf    = Twofish.new(key, :mode => :cbc, :padding => :zero_byte)
     tf.iv = vector_init || (Reloaded::Application.config.vector_init if vector_init.nil?)
     return tf.encrypt(content)
   end
   
   def twofish_decrypt(encontent,key,vector_init)
     require 'twofish'
     key   = Reloaded::Application.config.default_key_twofish if key.nil?
     tf    = Twofish.new(key, :mode => :cbc, :padding => :zero_byte)
     tf.iv = vector_init || (Reloaded::Application.config.vector_init if vector_init.nil?)
     return ciphertext = tf.decrypt(encontent)
   end
   
   #TripleDES   
   def tripledes_encrypt(content,key,vector_init)
      key   = Reloaded::Application.config.default_key_tripledes if key.nil?
      cipher = OpenSSL::Cipher::Cipher.new("des3")
      cipher.encrypt 
      cipher.key = key
      cipher.iv = vector_init || (Reloaded::Application.config.vector_init if vector_init.nil?)
      ciphertext = cipher.update(content)
      ciphertext << cipher.final
      return ciphertext
   end
   
   def tripledes_decrypt(encontent,key,vector_init)
      key    = Reloaded::Application.config.default_key_tripledes if key.nil?
      cipher = OpenSSL::Cipher::Cipher.new("des3")
      cipher.decrypt 
      cipher.key = key
      vector_init = vector_init || (Reloaded::Application.config.vector_init if vector_init.nil?)
      ciphertext = cipher.update(encontent)
      ciphertext << cipher.final
      return ciphertext
   end
   
   #Blowfish 
   def blowfish_encrypt(content,key)
     key    = Devise.secret_key if key.nil?
     cipher = OpenSSL::Cipher.new('bf-ecb').encrypt
     cipher.padding = 0
     cipher.key = key
     binary_data = cipher.update(content) << cipher.final
     hex_encoded = binary_data.unpack('H*').first
     return hex_encoded
   end
   
   def blowfish_decrypt(encontent,key)
     key    = Devise.secret_key if key.nil?
     cipher = OpenSSL::Cipher.new('bf-ecb').decrypt
     cipher.padding = 0
     cipher.key = key
     binary_data = [encontent].pack('H*')
     str = cipher.update(binary_data) << cipher.final
     return str.force_encoding(Encoding::UTF_8)
   end
  
    # AES
   def aes_encrypt(content,key)
     key     = Reloaded::Application.config.default_key_aes if key.nil?
     key     = Gibberish::SHA512(key)
     cipher  = Gibberish::AES.new(key)
     encoded = cipher.encrypt(content)
     return encoded
   end
  
   def aes_decrypt(encontent,key)
     key     = Reloaded::Application.config.default_key_aes if key.nil?
     key     = Gibberish::SHA512(key)
     cipher  = Gibberish::AES.new(key)
     decoded = cipher.decrypt(encontent)
     return decoded
   end
  
   # RSA
   def rsa_encrypt
     keypair          = Gibberish::RSA.generate_keypair(4096)
     self.public_key  = keypair.public_key
     self.private_key = keypair.private_key
     self.cipher      = Gibberish::RSA.new(keypair.public_key)
     self.encoded     = cipher.encrypt(self.content)
     self.content     = "ENCODED"
     self.sha512      = Gibberish::SHA512(self.encoded)
     self.save
     return self.encoded
   end
  
   def rsa_decrypt(content)
     @message = Message.find_by_read_token(self.read_token)
     cipher = Gibberish::RSA.new(self.private_key)
     decoded = cipher.decrypt(content)
     self.content = decoded
     self.save
     return self.content
   end
  
  
   private
   def generate_read_token
     begin
      self.read_token = SecureRandom.hex
     end while self.class.exists?(read_token: read_token)
     self.save
   end
  
   def read(token)
     @message = self.find_by_read_token(token)
     cipher = Gibberish::RSA.new(self.private_key)
     decoded = cipher.decrypt(encoded)
     self.content = decoded
     self.save
   end
   
   def autodestroy
     self.destroy
   end
     
   def notify_link
     if self.target_name.present?
         UserMailer.notify_message_ext_email(self.sender_id,self.target_name,self.read_token).deliver
     else
         UserMailer.notify_message_email(self.sender_id,self.target_id,self.read_token).deliver       
     end
   end

   def generate_entropy
     
   end
      
end
