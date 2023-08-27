# frozen_string_literal: true

require 'test_helper'

module Api
  class UsersControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
    end

    test 'should get api index' do
      get api_users_url(format: :json)
      assert_response :success
    end

    test 'should get api show' do
      get api_user_url(@user, format: :json)
      assert_response :success
    end
  end
end
