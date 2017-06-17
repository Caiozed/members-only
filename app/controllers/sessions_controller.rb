class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create 
  	@user = User.find_by(email: params[:session][:email])
  	if @user && @user.authenticate(params[:session][:password])
  		log_in @user
  		redirect_to root_path
  	else
  		flash.now[:danger] = "Wrong email/password"
  		render :new
  	end
  end

  def destroy
  	log_out 
  end

 
end
