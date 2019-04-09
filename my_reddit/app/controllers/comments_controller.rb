class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.author_id = current_user.id
        @comment.post_id = params[:post_id]
    end

    def new

    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
