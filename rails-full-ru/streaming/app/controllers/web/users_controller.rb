# frozen_string_literal: true

require 'csv'

module Web
  class UsersController < Web::ApplicationController
    # BEGIN
    include ActionController::Live
    # END

    def index
      @users = User.page(params[:page])
    end

    def show
      @user = User.find params[:id]
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find params[:id]
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to @user, notice: t('success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @user = User.find params[:id]

      if @user.update(user_params)
        redirect_to @user, notice: t('success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find params[:id]

      @user.destroy

      redirect_to users_url, notice: t('success')
    end

    def normal_csv
      respond_to do |format|
        format.csv do
          csv = generate_csv(User.column_names, User.all)
          send_data(csv)
        end
      end
    end

    # BEGIN
    def stream_csv
      response.headers['Last-Modified'] = Time.now.httpdate.to_s

      send_stream(filename: 'users.csv') do |stream|
        stream.write 'id,name,email,created_at,updated_at\n'

        User.find_each do |user|
          stream.write "#{user.id},#{user.name},#{user.email},#{user.created_at},#{user.updated_at}\n"
        end
      end
    end
    # END

    private

    def generate_csv(column_names, records)
      CSV.generate do |csv|
        csv << column_names # add headers to the CSV

        records.find_each do |record|
          csv << record.attributes.values_at(*column_names)
        end
      end
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email
      )
    end
  end
end
