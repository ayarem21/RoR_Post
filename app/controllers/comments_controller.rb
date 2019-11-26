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
    @post = Post.find(params[:post_id])
    @comment = @post.author.comments.find(params[:id])
  end

 def update
   @comment = Comment.find(params[:id])
   @post = Post.find(params[:post_id])
   
   respond_to do |format|
     if @comment.update(comment_params)
       format.html { redirect_to @post, notice: 'Post was successfully updated.' }
       format.json { render :show, status: :ok, location: @post }
     else
       format.html { render :edit }
       format.json { render json: @post.errors, status: :unprocessable_entity }
     end
   end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
