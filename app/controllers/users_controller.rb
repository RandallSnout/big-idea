class UsersController < ApplicationController
	before_action :current_user, only:[:edit, :update, :destroy]
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def new
  end
  def create
  	user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  	if user.save
  		session[:user_id] = user.id
  		redirect_to "/users/#{user.id}"
  	else
  		flash[:errors] = user.errors.full_messages
  	 	redirect_to '/users/new'
	 end
  end

  def show
    @user = User.find(current_user.id)
    @secrets = @user.secrets
  end

  def edit
  	@user = User.find(current_user.id)
  end

  def update
  	user = User.find(current_user.id)
  	user.update(name: params[:name], email: params[:email])
  	redirect_to action: "show"
  end

  def destroy
  	user = User.find(current_user.id)
  	user.destroy
  	reset_session
    redirect_to '/sessions/new'
  end
end