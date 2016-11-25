require 'autodns_api/log'
require 'autodns_api/transport'

module AutodnsAPI
  class Client
    attr_reader :transport
    
    def initialize(config)
      @config    = config
      @transport = AutodnsAPI::Transport.new(@config)
      check_config
    end

    private

    def check_config
      ensure_config_present!(:url)
      raise 'config url needs to start with https://' if @config[:url] !~ %r{^(https)://}

      ensure_config_present!(:user)
      ensure_config_present!(:password)
      ensure_config_present!(:context)
    end

    def ensure_config_present!(name)
      if !@config[name] || @config[name].to_s.empty?
        raise "missing #{name} in config"
      end
    end
  end
end