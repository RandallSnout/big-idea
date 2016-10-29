class SessionsController < ApplicationController

	def new
	end

	def create
		@user = User.new(name: params[:name],alias: params[:alias], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			redirect_to "/bright_ideas/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to :back
		end
	end


	def login
	 	@user = User.find_by_email(params[:email])
	 	if @user && @user.authenticate(params[:password]) 
	 		session[:user_id] = @user.id
	 		redirect_to "/bright_ideas/#{@user.id}"
	 	else
	 		flash[:error] = "Invalid Login"
	 		redirect_to :back
	 	end
	end

	def destroy
		reset_session
    	redirect_to "/"
	end
end
