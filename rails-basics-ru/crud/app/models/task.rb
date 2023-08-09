# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, :status, :creator, :completed, presence: true
end
