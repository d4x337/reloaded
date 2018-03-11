class CreateMailAccounts < ActiveRecord::Migration
  def self.up
     create_table :mail_accounts do |t|
       t.integer :user_id
       t.string :login
       t.string :name
       t.string :password
       t.string :tip
       t.integer :uid,:default => 2000
       t.integer :gid,:default => 2000
       t.string :home,:default => '/var/vmail'
       t.string :maildir, :default=>'d4x337.com/username'
       t.string :quota,:default => '1000000000S'
       t.integer :active,:default => 1
       t.timestamps
    end
    add_index :mail_accounts, :login, :unique => true
    
    self.load
 
  end
  
  def self.down
    drop_table :mail_accounts
  end
  
  def self.load
    MailAccount.create(:user_id=>1,:login=>'davide@d4x337.com',:name=>'d4x',:password=>'Blaster..14',:maildir=>'d4x337.com/davide/',:quota=>'100000000000S',:active=>1)
    MailAccount.create(:user_id=>2,:login=>'admin@reloaded.online',:name=>'Reloaded',:password=>'Pl0kta,,,',:maildir=>'reloaded.online/admin/',:quota=>'20000000000S',:active=>1)
  end
  
end
