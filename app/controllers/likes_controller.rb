class LikesController < ApplicationController

  def create
    idea = Idea.find(params['i_id'])
    like = Like.create(user: current_user, idea: idea)
    redirect_to :back
  end

end
