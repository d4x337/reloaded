class CreateAliasMaps < ActiveRecord::Migration
  def self.up
     create_table :alias_maps do |t|
      t.text :address
      t.string :alias,:default=>''
      t.string :domain,:default=>''
      t.integer :active,:default=>1
      t.timestamps
    end
    self.load
  end
  
  def self.down
    drop_table :alias_maps
  end

  def self.load
    AliasMap.create(:address=>'root@mail.reloaded.online',:alias=>'root@d4x337.com',:domain=>'d4x337.com')
    AliasMap.create(:address=>'davide@d4x337.com',:alias=>'root@d4x337.com',:domain=>'d4x337.com')
    AliasMap.create(:address=>'admin@reloaded.online',:alias=>'admin@reloaded.online',:domain=>'reloaed.online')
  end
end
