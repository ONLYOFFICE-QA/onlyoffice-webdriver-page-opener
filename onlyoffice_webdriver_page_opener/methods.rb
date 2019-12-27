# frozen_string_literal: true

# @return [String] url from data
def form_url
  url = URI.parse(ENV['URL'])
  url.query = URI.encode_www_form(username: Socket.gethostname)
  url.to_s
end
