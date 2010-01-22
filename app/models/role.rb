class Role < ActiveRecord::Base

  has_many :user_roles
  has_many :users, :through => :user_roles

  after_destroy :update_roles_cached
  # after_update  :update_roles_cached
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_format_of   :name, :with => /^[A-Z0-9\_\-]+$/i, :message => " is invalid (alphanumeric, dashes, and underscores only)"



protected

  # Force update users to reset the denomralized cache
  def update_roles_cached
    # Can take awhile if many, many users!
    # If this gets bigger, might be worth looking into spawning this request.
    User.all.each{|u| u.save!}
  end

end
