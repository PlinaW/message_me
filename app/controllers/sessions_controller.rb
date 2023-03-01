class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
    
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to root_path      
    else
      flash.now[:error] = "There was something wrong with your login details" #regular fflash has to turnaround of one request response cycle
      render 'new'                                                            # And since I'm rendering the new form again, then on the next view, 
                                                                              # it would show up with this message and we don't want that.
                                                                              # We wanted to show up on the same one.
                                                                              # So we'll do render new here and use Flash now instead of just regular flash.
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to root_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end     
  end
end