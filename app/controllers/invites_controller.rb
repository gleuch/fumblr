class InvitesController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]


  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(params[:invite])
    if @invite.save
      flash[:notice] = "Thanks for your excitement in trying #{configatron.site_name}! You will receive an email when your invite has been approved."
      # redirect_back_or_default(root_path)
      redirect_error_page_back_or_default(root_path)
    else
      flash[:error] = 'Sorry, but there was an error with your invite.'
      render :action => 'new'
    end
  end

end
