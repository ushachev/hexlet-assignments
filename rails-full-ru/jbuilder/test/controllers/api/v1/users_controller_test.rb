# frozen_string_literal: true

require 'test_helper'

module HexletCheck
  module Api
    module V1
      class UsersControllerTest < ActionDispatch::IntegrationTest
        setup do
          @user = users(:one)
        end

        test 'should get index' do
          get api_v1_users_url(format: :json)
          assert_response :success
        end

        test 'should get show' do
          get api_v1_user_url(@user, format: :json)
          assert_response :success
        end
      end
    end
  end
end
