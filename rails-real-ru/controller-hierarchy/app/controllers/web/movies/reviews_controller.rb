# frozen_string_literal: true

module Web
  module Movies
    class ReviewsController < Web::Movies::ApplicationController
      def index
        @reviews = resource_movie.reviews
      end

      def new
        @review = resource_movie.reviews.build
      end

      def create
        @review = resource_movie.reviews.build(permitted_params)

        if @review.save
          redirect_to movie_reviews_path(resource_movie), notice: I18n.t('success')
        else
          render :new, status: :unprocessable_entity, alert: I18n.t('fail')
        end
      end

      def edit
        @review = resource_movie.reviews.find(params[:id])
      end

      def update
        @review = resource_movie.reviews.find(params[:id])

        if @review.update(permitted_params)
          redirect_to movie_reviews_path(resource_movie), notice: I18n.t('success')
        else
          render :edit, status: :unprocessable_entity, alert: I18n.t('fail')
        end
      end

      def destroy
        review = resource_movie.reviews.find(params[:id])

        review.destroy

        redirect_to movie_reviews_path(resource_movie), notice: I18n.t('success')
      end

      private

      def permitted_params
        params.require(:review).permit(:body)
      end
    end
  end
end
