# frozen_string_literal: true

require 'open-uri'

class Hacker
  class << self
    def hack(email, password)
      # BEGIN
      hostname = 'https://rails-collective-blog-ru.hexlet.app'
      sign_up_path = 'users/sign_up'
      register_path = 'users'
      token_css_selector = 'input[@name="authenticity_token"]'

      sign_up_response = URI.open(URI.join(hostname, sign_up_path))

      token = Nokogiri::HTML(sign_up_response.read).at(token_css_selector)['value']
      params = {
        'user[email]': email,
        'user[password]': password,
        'user[password_confirmation]': password,
        authenticity_token: token
      }
      cookie = sign_up_response.meta['set-cookie'].split('; ').first

      request = Net::HTTP::Post.new URI.join(hostname, register_path)
      request.body = URI.encode_www_form(params)
      request['Cookie'] = cookie

      uri = URI(hostname)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      response = http.request request
      response.code == '302'
      # END
    end
  end
end
