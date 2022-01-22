class CommentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_comment, only: %i[ :destroy ]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable
    else
      redirect_to @commentable, alert: "Something went wrong"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@commentable), status: :see_other, notice: "comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # def set_comment
    #   @comment = Comment.find(params[:id])
    # end

    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
