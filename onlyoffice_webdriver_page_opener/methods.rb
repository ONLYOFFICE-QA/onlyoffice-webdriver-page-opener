# frozen_string_literal: true

# @return [String] url from data
def form_url
  url = URI.parse(ENV['URL'])
  query = if url.query
            CGI.parse(url.query)
          else
            {}
          end
  query[:username] = Socket.gethostname
  url.query = URI.encode_www_form(query)
  url.to_s
end
