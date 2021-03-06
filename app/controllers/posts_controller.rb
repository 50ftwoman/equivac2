class PostsController < ApplicationController

  def index
    if request.query_parameters[:category] == 'service'
      @posts = Post.where(category_id: 1)
    elsif request.query_parameters[:category] == 'need'
      @posts = Post.where(category_id: 2)
    else
      @posts = Post.all
    end

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comment.user = current_user
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def edit
    @post = Post.find(params[:id])

  end


def update
  @post = Post.find(params[:id])
  if @post.update_attributes(params.require(:post).permit(:title, :body, :image))
    redirect_to posts_path
  else
    render :edit
end
end

  def create
    @post = current_user.posts.create(params.require(:post).permit(:title, :category_id, :image, :body))
    if @post.save
      # If user saves in the db successfully:
      flash[:notice] = "Posted!"
      redirect_to root_path
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't post."
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
end
