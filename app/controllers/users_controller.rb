class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def index
      @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver

      redirect_to controller: 'sessions', action: 'new', :notice => "Signed up!"
    else
      render 'new'
    end
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
 
      redirect_to users_path
  end

  private
  def user_params
    	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
