require 'json'
module Lorem
  class App

    attr_accessor :env

    def call(env)
      @env = env

      if request.path == "/"
        render_home_page
      elsif request.path == '/lorem'
        render_lorem_text
      else
        render_not_found
      end
    end

    def request
      Rack::Request.new(env)
    end

    def lorem_text
      number = request.params['n'] || request.params['number']  || 1
      type   = request.params['t'] || request.params['type']    || :paragraphs # paragraphs, words, chars, characters
      Lorem::Base.new(type, number).output
    end

    def render_home_page
      [
        200,
        {
          'Content-Type'  => 'text/html',
          'Cache-Control' => 'public, max-age=86400'
        },
        File.open('public/index.html', File::RDONLY)
      ]
    end

    def render_lorem_text
      [
        200,
        {
          'Content-Type'  => 'application/json'
        },
        [{text: lorem_text}.to_json]
      ]
    end

    def render_not_found
      [
        404,
        {'Content-type' => 'text/plain'},
        ['']
      ]
    end
  end
end
