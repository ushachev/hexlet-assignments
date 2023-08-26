# frozen_string_literal: true

require 'test_helper'

module Web
  class ReviewsControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get reviews_url
      assert_response :success
    end
  end
end
