# frozen_string_literal: true

require 'digest'

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    time_start = Time.now
    status, headers, body = @app.call(env)
    time_stop = Time.now

    puts "Response time: #{((time_stop - time_start) * 1_000_000).to_i} microsec"

    [status, headers, body]
  end
end
