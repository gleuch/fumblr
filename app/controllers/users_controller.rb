class UsersController < ApplicationController
  # skip_before_filter :verify_authenticity_token, :only => :create

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
    render :action => :edit
  end
  
  def create
    @user = User.new(params[:user])

    recaptcha = configatron.enable_recaptcha ? verify_recaptcha(:model => @user, :message => 'Oh! It\'s error with reCAPTCHA!') : true

    if recaptcha && @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :edit
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
