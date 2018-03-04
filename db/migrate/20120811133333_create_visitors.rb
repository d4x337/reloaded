class CreateVisitors < ActiveRecord::Migration
  
  def self.up
    create_table :visitors do |t|
      t.string :session_id
      t.string :nickname
      t.integer :user_id
      
      t.text :user_agent
      t.text :headers
      t.string :visited_url
      t.string :remote_ip
      t.string :referer
      t.string :method
      t.string :remote_host
      t.string :http_accept
      t.text :query_string
      t.text :cookie_string   
      t.string :geo_ip_country
      t.string :geo_ip_city
      t.string :cords
      t.boolean :active,:default =>true
      t.boolean :expired,:default=>false
      t.datetime :expired_at
      t.boolean :deleted,:default=>false
      t.timestamps
    end
  end

  def self.down
      drop_table :visitors
  end
  
end