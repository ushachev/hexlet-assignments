# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  # BEGIN
  resources :posts do
    scope module: :posts do
      resources :post_comments, except: %i[index show new], controller: 'comments'
    end
  end
  # END
end
