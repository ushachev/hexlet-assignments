# frozen_string_literal: true

require 'octokit'

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(id)
    repository = Repository.find(id)
    repository.fetch!

    client = Octokit::Client.new
    octokit_repo = Octokit::Repository.from_url(repository.link)
    github_data = client.repository(octokit_repo)

    repository.update!(
      repo_name: github_data[:name],
      owner_name: github_data[:owner][:login],
      description: github_data[:description],
      default_branch: github_data[:default_branch],
      watchers_count: github_data[:watchers_count],
      language: github_data[:language],
      repo_created_at: github_data[:created_at],
      repo_updated_at: github_data[:updated_at]
    )

    repository.complete!
  rescue StandardError
    repository.fail!
  end
end
