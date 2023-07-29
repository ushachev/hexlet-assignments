# frozen_string_literal: true

require_relative './vehicle'

class Bus
  include Vehicle

  def bus?
    true
  end
end
