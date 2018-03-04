class CreateShadows < ActiveRecord::Migration
  def self.up
    create_table :shadows do |t|
      t.integer   :sender_id
      t.integer   :recipient_id
      t.string    :sender_email
      t.string    :recipient_email
      t.text      :content
      t.timestamps
    end

  end

  def self.down
    drop table :shadows
  end
end
