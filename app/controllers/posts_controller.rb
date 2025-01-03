class PostsController < ApplicationController
  # Se quiser exigir login para criar/editar/excluir posts:
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # Pegar todos os posts, ordenados do mais novo para o mais antigo
    # e paginar a cada 3 posts (usando uma gem de paginação)
    @posts = Post.order(created_at: :desc).page(params[:page]).per(3)

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "Post atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post removido."
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
