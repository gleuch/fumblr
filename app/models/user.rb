class UserSession < Authlogic::Session::Base
  # Slow down how much this updates the user, since this also triggers denormalization.
  last_request_at_threshold(15.minutes)
end


class User < ActiveRecord::Base
  include AASM

  # Acts as state machine setup
  aasm_column :status
  aasm_initial_state  :registered

  aasm_state :registered
  aasm_state :invited, :enter => :make_invited
  aasm_state :activated, :enter => :make_activated
  aasm_state :banned

  # Invite a user
  aasm_event :invite do
    transitions :to => :invited, :from => [:registered]
  end

  # Confirm a user
  aasm_event :activate do
    transitions :to => :activated, :from => [:invited]
  end
  
  # Ban a user
  aasm_event :ban do
    transitions :to => :banned, :from => [:registred, :invited, :activated]
  end


  # Authlogic additional validations
  acts_as_authentic do |c|
  end


  # Callback hooks
  before_save :denormalize_roles


  # Associations
  belongs_to  :invite
  has_many    :sent_invites, :class_name => 'Invite', :foreign_key => 'sender_id'

  has_many :user_roles
  has_many :roles, :through => :user_roles, :source => :role


  # Does user have specified role?
  def has_role?(name = :admin)
    @roles_list ||= self.roles_cached.split(',')
    (@roles_list || []).include?(name.to_s)
  end



protected

  def make_invited
    self.update_attributes!(:invited_at => Time.now())
  end

  def make_activated
    self.update_attributes!(:activated_at => Time.now(), :activation_key => '')
  end

  # Make this easier by cacheing the roles when they are changed.
  def denormalize_roles
    self.roles_cached = (self.roles.collect(&:name) || []).join(',')
  end



private


end
