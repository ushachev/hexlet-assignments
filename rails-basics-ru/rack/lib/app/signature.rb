# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, body = @app.call(env)
    digest = Digest::SHA256.hexdigest(body)
    [status, headers, [body, digest]]
    # END
  end
end
