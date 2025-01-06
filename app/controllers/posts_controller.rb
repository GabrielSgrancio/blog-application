class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @posts = Post.order(created_at: :desc).includes(:tags).page(params[:page]).per(3)

    if params[:tag].present?
      tag = Tag.find_by(name: params[:tag])
      @posts = tag ? tag.posts.order(created_at: :desc) : Post.none
    end
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      if params[:post][:tag_names].present?
        @post.tags = params[:post][:tag_names].split(",").map do |tag_name|
          Tag.where(name: tag_name.strip).first_or_create!
        end
      end
      redirect_to @post, notice: t("blog.post_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def search_by_tag
    @posts = Post.joins(:tags).where(tags: { name: params[:tag] }).order(created_at: :desc).page(params[:page]).per(3)
    render :index
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_names)
  end
end
