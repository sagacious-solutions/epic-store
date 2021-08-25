class UsersController < ApplicationController

  def new
  end

  def create
    new_params = user_params

    new_params[:email] = user_params[:email].downcase

    user = User.new(new_params)


    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/registration'
    end
  end   

  private 
  def user_params
    params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation)
  end
end


