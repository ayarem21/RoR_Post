class CommentsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :find_post

  def index
    @post.comments = @post.comments.arrange(order: :created_at)
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_user.id
    if @comment.ancestors.count <= 4
      respond_to do |format|
        if @comment.save
          format.js {render 'create', status: :created, location: @post}
          format.html { redirect_to @post, notice: 'Comment was successfully created.' }

        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'To much comments in one tree (5 comments max)' }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])
    if @comment.ancestors.count <= 5
      respond_to do |format|
        if @comment.update(comment_params)
          format.js
        else
          format.html { render :edit }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js { render 'destroy', status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: 'Error!' }
      end
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :post_id, :parent_id)
  end


  def find_post
    @post = Post.find(params[:post_id])
  end

  def correct_user
    @comment = Post.find(params[:post_id])
    unless current_user
      redirect_to root_path(current_user)
    end
  end
end
