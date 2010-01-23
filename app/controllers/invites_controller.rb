class InvitesController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]


  def new
  end

  def create
  end

end
