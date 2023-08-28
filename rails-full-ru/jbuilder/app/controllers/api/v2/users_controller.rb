# frozen_string_literal: true

module Api
  module V2
    class UsersController < Api::ApplicationController
      # BEGIN
      def index
        users = User.all
        render json: users, each_serializer: UserSerializer
      end

      def show
        user = User.find(params[:id])
        render json: user, serializer: UserSerializer
      end
      # END
    end
  end
end
