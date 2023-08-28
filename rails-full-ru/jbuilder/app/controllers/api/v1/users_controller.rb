# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::ApplicationController
      # BEGIN
      def index
        @users = User.all
      end

      def show
        @user = User.find(params[:id])
      end
      # END
    end
  end
end
