# frozen_string_literal: true

module Web
  module Movies
    class CommentsController < Web::Movies::ApplicationController
      def index
        @comments = resource_movie.comments
      end

      def new
        @comment = resource_movie.comments.build
      end

      def create
        @comment = resource_movie.comments.build(permitted_params)

        if @comment.save
          redirect_to movie_comments_path(resource_movie), notice: I18n.t('success')
        else
          render :new, status: :unprocessable_entity, alert: I18n.t('fail')
        end
      end

      def edit
        @comment = resource_movie.comments.find(params[:id])
      end

      def update
        @comment = resource_movie.comments.find(params[:id])

        if @comment.update(permitted_params)
          redirect_to movie_comments_path(resource_movie), notice: I18n.t('success')
        else
          render :edit, status: :unprocessable_entity, alert: I18n.t('fail')
        end
      end

      def destroy
        comment = resource_movie.comments.find(params[:id])

        comment.destroy

        redirect_to movie_comments_path(resource_movie), notice: I18n.t('success')
      end

      private

      def permitted_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
