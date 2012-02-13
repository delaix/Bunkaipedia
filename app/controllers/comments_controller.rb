class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]


  def create
    comment = Comment.new(params[:comment])
    if comment.save
      flash[:success] = "Comment added."
      redirect_to bunkai_path(comment.bunkai)
    else
      flash.now[:error] = "Failed to add comment."
      @new_comment = comment
      @bunkai = comment.bunkai
      @techniques = @bunkai.techniques.order('id')
      @maneuvers = @bunkai.maneuvers.order('id')
      @comments = @bunkai.comments.order('id')
      render 'bunkai/show'
    end
  end
  
  
  def edit
    @comment = Comment.find(params[:id])
  end


  def update
    comment = Comment.find(params[:id])
    if current_user == comment.user
      if comment.update_attributes(params[:comment])
        flash[:success] = "Comment updated."
      else
        flash.now[:error] = "Failed to update comment."
        @comment = comment
        render :edit
        return
      end
    else
      flash[:error] = "Permission denied"
    end
    redirect_to bunkai_path(comment.bunkai)
  end
end
