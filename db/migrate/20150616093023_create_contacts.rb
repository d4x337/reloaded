class CreateContacts < ActiveRecord::Migration
  def self.up
     create_table :contacts do |t|
      t.integer :user_id
      t.string :fullname
      t.string :address
      t.string :city
      t.string :company
      t.string :headline
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :email
      t.string :mobile
      t.string :gender
      t.datetime :birthdate
      t.attachment :picture
      t.timestamps
    end
    add_index :contacts, :fullname, :unique => false
    self.load
  end
  
  def self.down
    drop_table :contacts
  end
 
  def self.load
    Contact.create(:user_id=>6,:fullname=>'Marco Pagni',:headline=>'Cameriere',:address=>'Via Chopin, 83',:city=>'Milano',:mobile=>'+39 333 4758139',:email=>'marco.pagni@html.it')
    Contact.create(:user_id=>6,:fullname=>'Daniele',:headline=>'Meccanico',:address=>'Via Ripamonti 194',:city=>'Milano',:mobile=>'+39 333 4758139',:email=>'daniele@tecnobike.biz')
    Contact.create(:user_id=>6,:fullname=>'Mario Rossi',:headline=>'Impiegato',:address=>'Corso Como 11',:city=>'Milano',:mobile=>'+39 333 4758139',:email=>'mario.rossi@gmail.com')
  end
  

end