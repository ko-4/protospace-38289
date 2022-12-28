class CommentsController < ApplicationController

  # def new
  #   @comment = Comment.new(comment_params)
  # end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
    @prototype = @comment.prototype
    @comments = @prototype.comments
    render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user, prototype_id: params[:prototype_id])
  end

end
