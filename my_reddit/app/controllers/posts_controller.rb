class PostsController < ApplicationController
  def new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if current_user.id == @post.author_id && @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  def upvote
    @post = Post.find(params[:post_id])
    @all_comments = @post.comments_by_parent_id
    Vote.create(value: 1, votable_type: Post, votable_id: params[:post_id])
    render :show
  end

  def downvote
    @post = Post.find(params[:post_id])
    @all_comments = @post.comments_by_parent_id
    Vote.create(value: -1, votable_type: Post, votable_id: params[:post_id])
    render :show
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
