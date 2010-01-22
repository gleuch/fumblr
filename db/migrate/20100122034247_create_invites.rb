class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.intger      :sender_id
      t.string      :email
      t.text        :token
      t.datetime    :sent_at
      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
