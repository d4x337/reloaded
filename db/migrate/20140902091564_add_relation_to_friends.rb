class AddRelationToFriends < ActiveRecord::Migration
 def self.up
    change_table :friends do |t|
      t.string :relation
    end
  end
  
  def self.down
      remove_column :friends, :relation, :string
  end
end
