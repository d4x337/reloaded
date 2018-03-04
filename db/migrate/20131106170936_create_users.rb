class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      
      #database authenticacle
      t.string :email, :null => false, :default => ""
      t.string :encrypted_password, :null => true
      
      #Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      
      #Rememberable
      t.datetime :remember_created_at
      
      t.integer :failed_attempts
      
      #Trackable
      t.integer :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      
      t.datetime :locked_at
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      
      #Encryptable
      t.string :password_salt
      
      
      #Confirmable
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      
      #Token Authenticable
      # t.string :authentication_token
      
      #reconfirmable
      t.string :unconfirmed_email
      
      #Invitable
      t.string     :invitation_token, :limit => 60
      t.datetime   :invitation_sent_at
      t.datetime   :invitation_accepted_at
      t.integer    :invitation_limit
      t.references :invited_by, :polymorphic => true
      t.integer    :invited_by_id
      
      t.string  :paypal_id
      t.string  :telephone
      t.string :theme
      t.datetime :last_seen
      t.string :nickname
      t.string :lastname
      t.string :firstname
      t.string :fullname
      t.string :gender
      t.string :country
      t.date :birthday
      t.boolean :approved, :default => true
      t.integer :roles_mask
      t.attachment :photo
      t.attachment :avatar
      t.attachment :cover
      t.string :skype_id
      t.string :twitter_url
      t.string :facebook_url
      t.string :linkedin_url
      t.string :other_url
      t.string :location
      t.string :work_at
      t.string :headline
      
      t.text :quote
      t.text :statement
      t.string :relation_status
      t.string :locale
      t.boolean :banned,:default => false
      t.integer :chat_status,:default=>0
      
      t.integer :secret_question_id
      t.string :secret_answer
      t.integer :secret_question_id2
      t.string :secret_answer2
      t.integer :secret_question_id3
      t.string :secret_answer3
      t.string :mobile
      t.string :external_token
      t.string :status
      t.boolean :on_mobile,:default=>false
      t.text :notes
      t.timestamps
   end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :invitation_token, :unique => true
  end

  def self.down
    drop_table :users
  end
  
end
