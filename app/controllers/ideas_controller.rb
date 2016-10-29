class IdeasController < ApplicationController
	before_action :current_user, only:[:edit, :destroy]
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:index, :show, :edit, :destroy]

  def index
    @user = User.find(current_user.id)
    @ideas = Idea.all

  end

  def create
    user = User.find(params[:id])
    idea = user.ideas.new(content: params[:content])
     if idea.save
       redirect_to :back
     else
       flash[:errors] = idea.errors.full_messages
       redirect_to :back
     end
  end

  def show
  	@idea = User.joins(:ideas).select("content", :alias, "ideas.id").find_by("ideas.id = #{params[:id]}")
  	@likers = Like.joins(:user).select("users.id as id", "alias", "name").where("idea_id = #{params[:id]}")
  end

  def destroy
    idea = Idea.find(params[:id])
    idea.destroy if idea.user == current_user
    redirect_to action: "index"
  end

end
