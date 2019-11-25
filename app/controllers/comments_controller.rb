class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_user.id
    redirect_to post_path(@post)
    if @comment.save!
     flash.now[:danger] = "error"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

 def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
