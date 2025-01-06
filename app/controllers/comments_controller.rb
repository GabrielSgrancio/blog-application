class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)

      if user_signed_in?
        @comment.user = current_user
      end

      if @comment.save
        redirect_to @post, notice: "Comentário publicado."
      else
        redirect_to @post, alert: "Falha ao publicar comentário."
      end
    end

    def destroy
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])

     
      if @comment.user == current_user
         @comment.destroy
         end


      @comment.destroy
      redirect_to @post, notice: "Comentário removido."
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

      def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end
end
