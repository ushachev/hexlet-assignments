# frozen_string_literal: true

module Posts
  class CommentsController < Posts::ApplicationController
    before_action :set_comment, only: %i[edit update destroy]

    def edit
      resource_post
    end

    def create
      @comment = resource_post.post_comments.build(comment_params)

      if @comment.save
        redirect_to post_path(resource_post), notice: 'Post comment was successfully created.'
      else
        render 'posts/show', status: :unprocessable_entity
      end
    end

    def update
      if @comment.update(comment_params)
        redirect_to post_path(resource_post), notice: 'Post comment was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @comment.destroy

      redirect_to post_path(resource_post), notice: 'Post comment was successfully destroyed.'
    end

    private

    def set_comment
      @comment = PostComment.find(params[:id])
    end

    def comment_params
      params.require(:post_comment).permit(:body)
    end
  end
end
