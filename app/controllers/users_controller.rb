class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:create, :new]
  before_filter :skip_password_attribute, :only => :update
  def index
    @users = User.all
  end

  def new
  	@user = User.new
    render layout: 'session'
  end

  def create
  	@user = User.new(user_params)
    if @user.valid?
      if @user.save
        sign_in @user
        redirect_to @user, :flash => {notice: "Created the new user!"}
      else
        render layout: 'session', action: 'new'
      end
    else
      flash.alert = "Unable to create user!"
      render layout: 'session', action: 'new'
    end
  end

  def show
  	@user = User.find_by_id(params[:id])
    if @user.nil?
      redirect_to action: 'index', :flash => {:notice => "Error showing user"}
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      current_user = @user
      redirect_to @user
    else
      flash.alert = "There was an error saving your profile"
      render 'edit'
    end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :first_name, :last_name, :username)
  end

  def skip_password_attribute
    if params[:password].blank?
      params.except!(:password)
    end
  end
end
