class LikesController < ApplicationController
  before_action :find_comment

  def create
    respond_to do |format|
      if @comment.likes.create!(author: current_user, value: 1)
        format.js { render 'comments/like', status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: "You can't like this twice" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.likes.create!(author: current_user, value: -1)
        format.js { render 'comments/like', status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: "You can't dislike this twice" }
      end
    end
  end

  private

  def find_comment
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
  end



  def already_liked?
    Like.where(author_id: current_user.id, comment_id: params[:comment_id]).exists?
  end
end
