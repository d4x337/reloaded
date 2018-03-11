class CreateDomains < ActiveRecord::Migration
   
  def self.up
     create_table :domains do |t|
      t.string :domain
      t.string :description
      t.integer :aliases,:default => 0
      t.integer :mailboxes,:default=>0
      t.integer :maxquota,:default=>0
      t.integer :backupmx,:default=>0
      t.string :transport
      t.integer :active,:default=>1
      t.datetime :expire_at
      t.string :homedir
      t.string :vmaildir
      t.timestamps
    end
    add_index :domains, :domain, :unique => true
    self.load
  end
  
  def self.down
    drop_table :domains
  end
    
  def self.load
    Domain.create :domain => 'd4x337.com',   :homedir=>'d4x337.com',  :vmaildir=>'/var/vmail', :active =>0
    Domain.create :domain => 'reloaded.online',   :homedir=>'reloaded.online',  :vmaildir=>'/var/vmail', :active =>0
    Domain.create :domain => 'reloaded.fun',   :homedir=>'reloaded.fun',  :vmaildir=>'/var/vmail', :active =>0
    Domain.create :domain => 'reloaded.club',   :homedir=>'reloaded.club',  :vmaildir=>'/var/vmail', :active =>0
    Domain.create :domain => 'reloaded.science',   :homedir=>'reloaded.science',  :vmaildir=>'/var/vmail', :active =>0
  end
  
end
