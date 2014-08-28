require 'httpi'
require 'digest/sha1'
require 'singleton'

require_relative "cloutree/version"



module Cloutree
  class Client
    include Singleton
    attr_reader :app_key, :app_secret


    def self.configure(hash)
      self.instance(hash)
    end

    def initialize(hash)
      @app_key = hash[:app_key] || raise "Specify :app_key"
      @app_secret = hash[:secret] || raise "Specify :app_secret"
    end

    def upload(file)
      request = new_request

      request.headers["HTTP_API_KEY"] = app_key
      
      filename = File.basename(file)
      request.headers["HTTP_FILENAME"] = filename
      
      time = Time.now.to_i
      request.headers["HTTP_TIMESTAMP"] = time
      
      string_to_sha = [app_key, time, filename, app_secret].join(":")
      request.headers["HTTP_CHECKSUM"] = Digest::SHA1.hexdigest(string_to_sha)
      
      request.body = File.read(file)

      HTTPI.post(request, :curb)
    end

    def new_request
      HTTPI::Request.new("http://cloutr.ee/upload")
    end
  end
end
CC = Cloutree::Client