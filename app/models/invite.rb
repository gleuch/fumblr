class Invite < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'

  validates_presence_of :email
  validates_uniqueness_of :email, :message => 'has been used for an invite.'

  validate :recipient_is_not_registered
  validate :sender_has_invites, :if => :sender

  before_create :generate_token
  before_create :decrement_sender_count, :if => :sender


private

  def recipient_is_not_registered
    errors.add :email, 'is already registered' if User.find_by_email(email)
  end

  def sender_has_invites
    # unless sender.invite_limit > 0
    #   errors.add_to_base 'You have reached your limit of invites to send.'
    # end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def decrement_sender_count
    sender.decrement! :invite_limit
  end

end
