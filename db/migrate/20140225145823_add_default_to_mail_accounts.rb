class AddDefaultToMailAccounts < ActiveRecord::Migration

  def self.up
    change_table :mail_accounts do |t|
      t.boolean  :defaultbox, :default=>true
    end
  end
  
  def self.down
      remove_column :mail_accounts, :defaultbox, :boolean
  end

end
