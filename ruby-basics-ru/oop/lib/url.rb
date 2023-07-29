# frozen_string_literal: true

# BEGIN
require 'uri'

class Url
  extend Forwardable

  def initialize(uri_str)
    @url = URI(uri_str)
  end

  def_delegators :@url, :scheme, :host, :port

  def query_params
    (@url.query || '').split('&')
                      .to_h { |query| query.split('=') }
                      .transform_keys(&:to_sym)
  end

  def query_param(key, default = nil)
    query_params.fetch(key, default)
  end

  def ==(other)
    scheme == other.scheme &&
      host == other.host &&
      port == other.port &&
      query_params == other.query_params
  end
end
# END
