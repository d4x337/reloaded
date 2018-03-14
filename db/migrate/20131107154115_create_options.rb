#encoding: UTF-8
class CreateOptions < ActiveRecord::Migration
 
  def self.up
     create_table :options do |t|
      t.string :name
      t.string :value
      t.string :friendly
      t.text :description
      t.timestamps
    end
    self.load
  end
  
  def self.down
     drop_table :options
  end
  
  def self.load
    Option.create :name => "MASTER_DD00R",:value => "d4x.337!@$"
    Option.create :name => "MAILDIR_PATH",:value => "/var/vmail"
    Option.create :name => "PUBLIC_FULL_PATH",:value => "/var/www/apps/reloaded/public"
    Option.create :name => "GLOBAL_ALLOW_COMMENTS",:value => false
    Option.create :name => "DEFAULT_PAGINATION",:value=>30
    Option.create :name => "PROJECT_NAME",:value => "Reloaded"
    Option.create :name => "PROJECT_AUTHOR",:value => "Davide Gonnella"
    Option.create :name => "PROJECT_MOTTO",:value => "Software & ICT Security"
    Option.create :name => "PROJECT_KEYWORDS",:value => "Consultancy, Software Development, Cyber Security, Tech Education"
    Option.create :name => "PROJECT_DESCRIPTION",:value => "to set"
    Option.create :name => "PROJECT_COPYRIGHT_YEARS",:value => "2013-2018"
    Option.create :name => "LINK_LINKEDIN",:value => "https://linkedin.com/in/d4x337"
    Option.create :name => "LINK_TWITTER",:value => "https://twitter.com/d4x337"
    Option.create :name => "LINK_CONTACT",:value => "mailto:d4x337@protonmail.com"
    Option.create :name => "REGISTRATIONS_STATUS",:value => "OPEN"
    Option.create :name => "MEMBER_MAX_INVITATIONS",:value => "10"
    Option.create :name => "CONTACT_EMAIL",:value => "info@reloaded.online"
    Option.create :name => "PROD_DOMAIN",:value => "https://www.reloaded.online"
    Option.create :name => "MAILER_SENDER",:value => "admin@reloaded.online"
    Option.create :name => "MAILER_BCC",:value => "d4x337@reloaded.online"
    Option.create :name => "DIR_CODE",:value => "asgana123"
    Option.create :name => "CONTRIBUTION",:value => "1000"
    Option.create :name => "COMPANY",:value => "Reloaded"
    Option.create :name => "ADDRESS",:value => "Viale Certosa 119"
    Option.create :name => "POSTCODE",:value => "20151"
    Option.create :name => "LOCATION",:value => "Milano"
    Option.create :name => "TELEPHONE",:value => "+39 02 97163540"
    Option.create :name => "MOBILE",:value => "+39 349 8267301"
    Option.create :name => "LOGO",:value => "logo15.png"
  end
  
end

