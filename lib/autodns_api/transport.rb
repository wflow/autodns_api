require 'autodns_api/version'
require 'faraday'
require 'openssl'
require 'nokogiri'

module AutodnsAPI
  class Transport

    attr_accessor :url, :user, :password
    attr_reader :config, :logger

    def initialize(config)
      @logger = Log.logger
      logger.info "Transport to #{config[:url]} with #{config[:user]}:#{config[:password]}"
      @conn = Faraday.new(url: config[:url]) do |faraday|
        #faraday.build_xml  :url_encoded             # form-encode POST params
        #faraday.response :logger                  # log requests to STDOUT
        faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
      end
      @conn.headers[:user_agent] = "Autodns API Ruby Client #{AutodnsAPI::VERSION}"
      @conn.basic_auth(config[:user], config[:password])
      @config = config
    end

    # @return [Nokogiri::XML::Document]
    def build_xml
      content = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.request {
          xml.auth {
            xml.user config[:user]
            xml.password config[:password]
            xml.context 
          }
          xml.task {
            yield xml
          }
        }
      end

      logger.debug content.to_xml

      content.to_xml
    end

    # @return [Faraday::Response]
    def post
      body = build_xml do |xml|
        yield xml
      end
      logger.debug "url=#{config[:url]} body=#{body.inspect}"
      response = @conn.post do |req|
        req.url config[:url]
        req.headers['Content-Type'] = 'application/xml'
        req.body = body
      end
      logger.debug "response=#{response.body}"

      response
    end

    # @return [Nokogiri::XML::Document]
    def request
      response = post do |xml|
        yield xml
      end

      Nokogiri.parse(response.body)
    end
  end
end
