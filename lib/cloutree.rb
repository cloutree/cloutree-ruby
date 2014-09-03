require 'digest/sha1'
require 'singleton'
require 'json'

require_relative "cloutree/version"



module Cloutree
  class Error < StandardError; ; end

  class Client
    include Singleton
    attr_accessor :app_key, :app_secret
    attr_reader :result

    def self.configure(hash)
      raise Cloutree::Error, "Specify :app_key" unless instance.app_key = hash[:app_key]
      raise Cloutree::Error, "Specify :app_secret" unless instance.app_secret = hash[:app_secret]
      instance
    end
  

    def self.upload(file)
      raise Cloutree::Error, "Configure Cloutree::Client before uploading:  
        CC.configure(app_key: YOUR_KEY, app_secret: YOUR_SECRET)" unless instance.app_key && instance.app_secret
      instance.upload(file)
    end


    def self.result
      unless instance.result 
        raise Cloutree::Error, "Try to upload something first. CC.upload(filepath)"
      end
      instance.result
    end


    def upload(file)
      filename = File.basename(file)
      time = Time.now.to_i
      string_to_sha = [app_key, time, filename, app_secret].join(":")
      checksum = Digest::SHA1.hexdigest(string_to_sha)

      c = Curl::Easy.new("https://cloutr.ee/upload")
      c.ssl_verify_peer = false
      c.headers["KEY"] = "#{app_key}"
      c.headers["CHECKSUM"] = "#{checksum}"
      c.headers["FILENAME"] = "#{filename}"
      c.headers["TIMESTAMP"] = "#{time}"
      c.http_post(File.read(file))
      @result = JSON.parse(c.body_str)
      @result["success"]
    end 

  end
end
CC = Cloutree::Client