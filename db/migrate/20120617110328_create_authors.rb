#encoding: UTF-8
class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string    :fullname
      t.string    :country
      t.string    :dates
      t.string    :headline
      t.string    :photo_file_name
      t.string    :photo_content_type
      t.integer   :photo_file_size
      t.text      :notes
      t.timestamps
    end
    self.load
  end
  
  def self.down
    drop_table :authors
  end
  
  def self.load
    Author.create :fullname => "iIIuminati"
    Author.create :fullname => "Confucio", :headline => "Filosofo cinese", :dates => "551 a.C. - 479 a.C. "
    Author.create :fullname => "Albert Einstein",:author_prof => "Fisico e matematico", :author_dates => "1879 - 1955 "
    Author.create :fullname => "Buddha"
    Author.create :fullname => "Italo Svevo", :author_dates => "1861 - 1928", :headline => "Scrittore"
    Author.create :fullname => "Jim Morrison", :author_dates => "1861 - 1928", :headline => "Poeta e Cantante"
    Author.create :fullname => "Aristotele"
    Author.create :fullname => "Dr.House"
  end
  
end

