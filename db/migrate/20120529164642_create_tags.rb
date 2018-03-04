class CreateTags < ActiveRecord::Migration
  def self.up
      create_table :tags do |t|
      t.string :name
      t.string :slug
      t.integer :term_group, :default => 0
    end
    self.load
  end

  def self.down
     drop_table :tags
  end
  
  def self.load
    Tag.create  :name => 'd4xBlog', :slug => 'd4xblog'
    Tag.create  :name => 'Events', :slug => 'eventz'
    Tag.create  :name => 'Geek News', :slug => 'news'
    Tag.create  :name => 'Hacking', :slug => 'hacking'
    Tag.create  :name => 'OpenBSD', :slug => 'puffy'
    Tag.create  :name => 'Security', :slug => 'security'
    Tag.create  :name => 'Submissions', :slug => 'submissions'
    Tag.create  :name => 'Threats', :slug => 'threats'
    Tag.create  :name => 'Tools', :slug => 'toolz'
    Tag.create  :name => 'Wireless', :slug => 'wireless'
    Tag.create  :name => '0Day', :slug => '0day'
    Tag.create  :name => 'DNS', :slug => 'dns'
    Tag.create  :name => '*nix', :slug => 'nix'
    Tag.create  :name => 'exploit', :slug => 'exploit'
    Tag.create  :name => 'linux', :slug => 'linux'
    Tag.create  :name => 'postExploit', :slug => 'postexploit'
    Tag.create  :name => 'OpenBSD', :slug => 'puffy'
    Tag.create  :name => 'Shellcodes', :slug => 'shellcodes'
    Tag.create  :name => 'Toolz', :slug => 'toolz'
    Tag.create  :name => 'Windows', :slug => 'windows'
    Tag.create  :name => 'Member Menu', :slug => 'member-menu'
    Tag.create  :name => 'Equipment', :slug => 'equipment'
    Tag.create  :name => 'SupporterMenu', :slug => 'supportermenu'
    Tag.create  :name => 'GuestMenu', :slug => 'guestmenu'
    Tag.create  :name => 'friends', :slug => 'friends'
    Tag.create  :name => 'hacking - pentest', :slug => 'hacking-pentest'
    Tag.create  :name => 'forensics', :slug => 'forensics'
    Tag.create  :name => 'education', :slug => 'education'
    Tag.create  :name => 'security', :slug => 'security-2'
    Tag.create  :name => 'news', :slug => 'news'
    Tag.create  :name => 'event', :slug => 'event'
    Tag.create  :name => 'causes', :slug => 'causes'
    Tag.create  :name => 'programming', :slug => 'programming'
    Tag.create  :name => 'cool stuff', :slug => 'cool-stuff'
    Tag.create  :name => 'geek', :slug => 'geek'
    Tag.create  :name => 'sexy', :slug => 'sexy'
  end
end
