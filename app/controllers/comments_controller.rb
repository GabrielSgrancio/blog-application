class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      
      if user_signed_in?
        @comment.user = current_user
      end
      # Se não estiver logado, user = nil -> comentário anônimo
  
      if @comment.save
        redirect_to @post, notice: "Comentário publicado."
      else
        redirect_to @post, alert: "Falha ao publicar comentário."
      end
    end
  
    def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
      
      # Regras de permissão: se quiser que apenas quem comentou possa apagar, verifique:
      # if @comment.user == current_user
      #   @comment.destroy
      # end
      # ou permita que o dono do post também apague, se quiser.
  
      @comment.destroy
      redirect_to @post, notice: "Comentário removido."
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  