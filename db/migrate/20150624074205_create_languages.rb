class CreateLanguages < ActiveRecord::Migration
  
  def self.up
    create_table :languages do |t|
     t.string :iso_language
     t.string :locale
     t.string :en_desc
     t.boolean :default
     t.boolean :active
    end
  end
  
  def self.down
     remove_column :languages, :iso_language, :string
     remove_column :languages, :locale, :string
     remove_column :languages, :en_desc, :string
     remove_column :languages, :default, :boolean
     remove_column :languages, :active, :boolean
  end
  
end
