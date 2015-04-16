class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:create, :new]
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

  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :first_name, :last_name, :username)
  end
end
