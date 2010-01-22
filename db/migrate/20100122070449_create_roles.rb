class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string      :name
      t.text        :description
      t.timestamps
    end
    
    create_table :user_roles, :id => false do |t|
      t.integer     :user_id
      t.integer     :role_id
      t.datetime    :created_at
    end

    Role.create(:name => 'admin', :description => 'Generic admin access')
  end

  def self.down
    drop_table :roles
    drop_table :user_roles
  end
end
