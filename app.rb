require 'rack'
require_relative 'view'

class App
  PAGES = %w{ /garbatella /testaccio /eur }

  def call(env)
    response_headers = {}
    response_body = []

    ### cookies

    request_cookies = Rack::Utils.parse_cookies(env)

    # set the session identifier if one doesn't already exist

    unless request_cookies["session_key"]
      Rack::Utils.set_cookie_header!(response_headers, "session_key", Time.now.to_f)
    end

    # count the number of page visits

    # nil.to_i returns 0, so if this cookie isn't set, the count will be 0:
    count = request_cookies["session_count"].to_i
    count += 1
    Rack::Utils.set_cookie_header!(response_headers, "session_count", count)

    ### routing

    path = env["PATH_INFO"]

    if PAGES.include? path
      status = 200
      view_path = path.gsub(/\W/, '')
    else
      status = 404
      view_path = "404"
    end

    ### create and render the view

    view = View.new(view_path, visit_count: count)
    response_body << view.render

    ### return the response object

    [status, response_headers, response_body]
  end
end

Rack::Handler::WEBrick.run App.new
