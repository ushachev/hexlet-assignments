# frozen_string_literal: true

class Post < ApplicationRecord
  # BEGIN
  has_many :post_comments, dependent: :destroy
  # END

  validates :title, presence: true
  validates :body, length: { maximum: 500 }
end
