require 'net/http'
require 'socksify/http'

module Tor

  class Configuration

    attr_accessor :ip,
                  :port

    attr_reader :headers

    def add_header(header, value)
      @headers[header] = value
    end

    def initialize
      @ip      = ENV[RAILS_ENV]
      @port    = 9050
      @headers = Hash.new
    end

  end

end
