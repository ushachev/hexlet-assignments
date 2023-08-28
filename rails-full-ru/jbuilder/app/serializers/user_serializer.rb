# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :address

  has_many :posts

  attribute :full_name do
    "#{object.first_name} #{object.last_name}}"
  end
end
