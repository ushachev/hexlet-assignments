# frozen_string_literal: true

require 'test_helper'

module Web
  class RepositoriesControllerTest < ActionDispatch::IntegrationTest
    # BEGIN
    test 'should create' do
      gh_repo = 'hexlet-basics/hexlet-basics'
      attrs = {
        link: "https://github.com/#{gh_repo}"
      }
      response = load_fixture('files/response.json')

      stub_request(:get, "https://api.github.com/repos/#{gh_repo}")
        .to_return(
          status: 200,
          body: response,
          headers: { 'Content-Type' => 'application/json' }
        )

      post repositories_url, params: { repository: attrs }

      repository = Repository.find_by attrs

      assert { repository }
      assert { repository.description.present? }
      assert_redirected_to repository_url(repository)
    end
    # END
  end
end
