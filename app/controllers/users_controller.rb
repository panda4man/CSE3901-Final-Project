class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:create, :new]

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
    auth = User.authenticate(user_params[:email], user_params[:password])
    if !auth.nil?
      if @user.update(user_params)
        current_user = @user
        flash.alert = "Profile updated."
        redirect_to @user
      else
        flash.alert = "There was an error saving your profile"
        render 'edit'
      end
    else
      flash.alert = "You entered an incorrect password."
      render 'edit'
    end
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :first_name, :last_name, :username)
  end
end
