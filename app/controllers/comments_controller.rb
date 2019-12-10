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
    #redirect_to post_path(@post)
    #if @comment.save!
    # flash.now[:danger] = "error"
    # format.js
    #end
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
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

 def update
   @post = Post.find(params[:post_id])
   @comment = Comment.find(params[:id])
   if @coment.ancestors.count <=5
     respond_to do |format|
       if @comment.update(comment_params)
         format.html { redirect_to @post, notice: 'Post was successfully updated.' }
         format.json { render :show, status: :ok, location: @post }
         format.js
       else
         format.html { render :edit }
         format.json { render json: @post.errors, status: :unprocessable_entity }
         format.js
       end

     end
   end
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :parent_id)
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
