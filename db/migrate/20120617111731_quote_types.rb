class QuoteTypes < ActiveRecord::Migration
 def self.up  
    create_table :quote_types do |t|
      t.string    :type_of_quote
      t.boolean   :visible,:default => true
      t.timestamps
      end
      self.load
  end

  def self.down
   drop_table :quote_types
  end
  
  def self.load
    QuoteType.create :type_of_quote => "proverb"
    QuoteType.create :type_of_quote => "famous"
    QuoteType.create :type_of_quote => "movie"
    QuoteType.create :type_of_quote => "ispirational"
  end
  
end
