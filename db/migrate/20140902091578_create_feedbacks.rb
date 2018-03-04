class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :from
      t.string :email
      t.string :reason
      t.text :message,:size=>"400"
      t.integer :rating
      t.string :ip
      t.string :country
      t.datetime :sent_at   
      t.boolean :deleted,:default=>false
      t.timestamps
    end
  end
    
  def self.down
    drop_table :feedbacks
  end

end
