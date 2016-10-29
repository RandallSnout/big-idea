class UsersController < ApplicationController
	before_action :current_user, only:[:edit, :destroy]
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :destroy]

  def show
    @user = User.find(params[:id])
    @idea = @user.ideas.all
    @likes = @user.likes.all
  end

  def edit
  	@user = User.find(current_user.id)
  end

  def destroy

  end
end