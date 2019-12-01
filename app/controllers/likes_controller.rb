class LikesController < ApplicationController
  before_action :find_comment

  def create
    @comment.likes.create(author_id: current_user.id)
    redirect_to post
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
