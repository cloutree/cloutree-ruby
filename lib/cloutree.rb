require 'digest/sha1'
require 'singleton'

require_relative "cloutree/version"



module Cloutree
  class Client
    include Singleton
    attr_accessor :app_key, :app_secret
    attr_reader :result

    def self.configure(hash)
      raise "Specify :app_key" unless instance.app_key = hash[:app_key]
      raise "Specify :app_secret" unless instance.app_secret = hash[:app_secret]
      instance
    end

    
    def self.upload(file)
      raise "Configure Cloutree::Client before uploading:  
             CC.configure(app_key: YOUR_KEY, app_secret: YOUR_SECRET)" unless instance.app_key && instance.app_secret
      instance.upload(file)
    end

    def self.result
      instance.result
    end


    def upload(file)
      filename = File.basename(file)
      time = Time.now.to_i
      string_to_sha = [app_key, time, filename, app_secret].join(":")
      checksum = Digest::SHA1.hexdigest(string_to_sha)

      command = "curl 'https://cloutr.ee/upload' "
      command += "--data-binary '@#{file}' "
      command += "-H 'KEY: #{app_key}' "
      command += "-H 'CHECKSUM: #{checksum}' "
      command += "-H 'FILENAME: #{filename}' "
      command += "-H 'TIMESTAMP: #{time}'"
      @result = system(command)
      @result
    end 

    # def upload_old(file)
    #   request = new_request

    #   request.headers["HTTP_KEY"] = app_key
      
    #   request.headers["HTTP_FILENAME"] = filename
      
    #   time = Time.now.to_i
    #   request.headers["HTTP_TIMESTAMP"] = time
      
    #   string_to_sha = [app_key, time, filename, secret].join(":")
    #   request.headers["HTTP_CHECKSUM"] = Digest::SHA1.hexdigest(string_to_sha)
      
    #   request.auth.ssl.verify = :none

    #   request.body = File.read(file)

    #   HTTPI.post(request, :curb)
    # end

  end
end
CC = Cloutree::Client