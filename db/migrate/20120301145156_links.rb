#encoding: UTF-8
class Links < ActiveRecord::Migration
  def self.up
     create_table :links do |t|
      t.string :url
      t.string :name
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.string :target, :default => "_blank"
      t.string :description
      t.integer :current_pos
      t.integer :last_pos
      t.string :trend
      t.integer :user_id
      t.boolean :visible, :default => true
      t.integer :rating, :default => 6, :comment =>'Link Rating' 
      t.string :rss
      t.text :notes
      t.timestamps
    end
    Links.load
  end
 
  def self.down
    drop_table :links
  end
  
   def self.load
    Link.create :current_pos => 14,:last_pos => 14,:trend =>'stable', :name => "PasteBin", :url => "http://pastebin.com/", :description => "#1 paste tool since 2002!",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 2, :last_pos => 11,:trend =>'up', :name => "TheHackerChoice", :url => "http://www.thc.org", :description => "#!/bin/the hacker's choice - THC",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 13,:last_pos => 12,:trend =>'donw', :name => "SecurityFocus", :url => "http://www.securityfocus.com", :description => "Information Security News",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 10, :last_pos => 13,:trend =>'', :name => "Exploit-DB", :url => "http://www.exploit-db.com", :description => "Exploits Database by Offensive Security",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 3,:last_pos => 5,:trend =>'', :name => "Insecure.org", :url => "http://insecure.org", :description => "Nmap, Tools & Hacking resources",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 7,:last_pos => 6,:trend =>'', :name => "PaulDotCom", :url => "http://www.pauldotcom.com", :description => "Home Of PaulDotCom Security Podcast",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 6,:last_pos => 7,:trend =>'', :name => "PacketStormSecurity", :url => "http://www.packetstormsecurity.org", :description => "Full Disclosure Information Security",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 8, :last_pos => 8,:trend =>'', :name => "OpenBSD", :url => "http://www.openbsd.org", :description => "main OpenBSD page",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 12,:last_pos => 19,:trend =>'', :name => "Jinx", :url => "http://www.jinx.com", :description => "Clothing Inspired by Video Games",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 20,:last_pos => 18,:trend =>'', :name => "ThinkGeek", :url => "http://www.thinkgeek.com", :description => ":: Stuff for Smart Masses",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 15,:last_pos => 17,:trend =>'', :name => "Punto Informatico", :url => "http://www.punto-informatico.it", :description => "Quotidiano italiano di informazione su Internet",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 9,:last_pos => 16,:trend =>'', :name => "Zero Day Initiative", :url => "http://www.zerodayinitiative.org", :description => "Zero Day Initiative",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 16,:last_pos => 20,:trend =>'', :name => "Hackers 4 Charity", :url => "http://www.hackers4charity.org", :description => "Hackers for Charity",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 4,:last_pos => 4,:trend =>'', :name => "2600", :url => "http://www.2600.com", :description => "The Hacker Quaterly",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 19,:last_pos => 20,:trend =>'', :name => "CloudCracker", :url => "http://www.cloudcracker.com", :description => ":: Online Hash Cracker",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 18,:last_pos => 15,:trend =>'', :name => "WarDriving", :url => "http://www.wardriving.com", :description => "Italian g News",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 17,:last_pos => 9,:trend =>'', :name => "L-Com", :url => "http://www.l-com.com", :description => "IEthernet Cable,Adapters, Wireless, L-com",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 5,:last_pos => 3,:trend =>'', :name => "Tor", :url => "http://www.punto-infadst", :description => "Tor Project: Anonymity Online",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 1,:last_pos => 1,:trend =>'', :name => "Metasploit", :url => "http://www.metasploit.com", :description => "Penetration Testing Software",:target =>"_blank",:user_id =>1
    Link.create :current_pos => 11,:last_pos => 2,:trend =>'', :name => "Phrack", :url => "http://www.phrack.org", :description => "Phrack Magazine",:target =>"_blank",:user_id =>1
  end
end
