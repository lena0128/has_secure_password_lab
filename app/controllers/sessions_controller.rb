class SessionsController < ApplicationController

  def new
  end

  def create
    if user_params[:password] == nil || user_params[:password].empty?
      redirect_to controller: "sessions", action: "new"
    else
        @user = User.find_by(name: user_params[:name])
          if @user.authenticate(user_params[:password])
             session[:user_id] = @user.id
             redirect_to controller: "welcome", action: "home"
          else
           redirect_to controller: "sessions", action: "new"
          end
    end
  end

  def destroy
    session.delete :name
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end

end
