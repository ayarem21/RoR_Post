class PostsController < ApplicationController
  impressionist actions: [:show], unique: [:session_hash]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: %i[:edit :update :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order('created_at DESC').paginate(page: params[:page], per_page: 8)
    if params[:search]
      @posts = Post.search(params[:search]).order('updated_at').paginate(page: params[:page], per_page: 8)
    else

      @posts = Post.all.order('updated_at').paginate(page: params[:page], per_page: 8)
      #@posts = Post.paginate(page: params[:page])
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    impressionist @post
  end

  # GET /posts/new
  def new
    @post = Post.new
    @authors = Author.all
  end

  # GET /posts/1/edit
  def edit
    @authors = Author.all
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :file)
    end

    def set_author
      @authors = Author.all
    end

    def correct_user
      @post = Post.find_by(id: params[:id])
      unless current_user?(@post.author)
        redirect_to author_path(current_user)
      end
    end

    def actions_check
      if cookies[:actions]
        cookies[:actions] = cookies[:actions].to_i + 1
      else
        cookies[:actions] = 0
      end
    end
end
