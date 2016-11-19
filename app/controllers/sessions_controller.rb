class SessionsController < ApplicationController
  def create 
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth 
    user = User.sign_in_from_facebook(auth)
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in successfully!"
  end

  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil 
    redirect_to root_url, notice: "Sign out successfully!"
  end
end
