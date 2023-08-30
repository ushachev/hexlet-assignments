# frozen_string_literal: true

# BEGIN
require 'octokit'
# END

module Web
  class RepositoriesController < Web::ApplicationController
    def index
      @repositories = Repository.all
    end

    def new
      @repository = Repository.new
    end

    def show
      @repository = Repository.find params[:id]
    end

    def create
      # BEGIN
      @repository = Repository.new(permitted_params)

      if @repository.save
        client = Octokit::Client.new

        octokit_repo = Octokit::Repository.from_url(@repository.link)

        repository_data = client.repository(octokit_repo)

        @repository.update!(
          repo_name: repository_data[:name],
          owner_name: repository_data[:owner][:login],
          description: repository_data[:description],
          default_branch: repository_data[:default_branch],
          watchers_count: repository_data[:watchers_count],
          language: repository_data[:language],
          repo_created_at: repository_data[:created_at],
          repo_updated_at: repository_data[:updated_at]
        )
        redirect_to @repository, notice: t('success')
      else
        flash[:notice] = t('fail')
        render :new, status: :unprocessable_entity
      end
      # END
    end

    def edit
      @repository = Repository.find params[:id]
    end

    def update
      @repository = Repository.find params[:id]

      if @repository.update(permitted_params)
        redirect_to repositories_path, notice: t('success')
      else
        flash[:notice] = t('fail')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @repository = Repository.find params[:id]

      if @repository.destroy
        redirect_to repositories_path, notice: t('success')
      else
        redirect_to repositories_path, notice: t('fail')
      end
    end

    private

    def permitted_params
      params.require(:repository).permit(:link)
    end
  end
end
