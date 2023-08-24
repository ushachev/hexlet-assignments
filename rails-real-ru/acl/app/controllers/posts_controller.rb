# frozen_string_literal: true

class PostsController < ApplicationController
  after_action :verify_authorized, except: %i[index show]

  # BEGIN
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    authorize Post

    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: I18n.t('posts.create.success')
    else
      render :new, status: :unprocessable_entity, alert: I18n.t('posts.create.failure')
    end
  end

  def edit
    @post = Post.find(params[:id])

    authorize @post
  end

  def update
    @post = Post.find(params[:id])

    authorize @post

    if @post.update(post_params)
      redirect_to @post, notice: I18n.t('posts.update.success')
    else
      render :edit, status: :unprocessable_entity, alert: I18n.t('posts.update.failure')
    end
  end

  def destroy
    post = Post.find(params[:id])

    authorize post

    post.destroy

    redirect_to posts_path, notice: I18n.t('posts.destroy.success')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
  # END
end
