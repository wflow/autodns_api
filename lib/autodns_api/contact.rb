require 'autodns_api/response'

module AutodnsAPI
  class Contact
    # @param [AutodnsAPI::Transport] transport
    # @param [String] name
    def self.all_by_name(transport, name='*')
      all_by(transport, :name, name)
    end

    # @param [AutodnsAPI::Transport] transport
    # @param [String] alias
    def self.all_by_alias(transport, an_alias='*')
      all_by(transport, :alias, an_alias)
    end
    
    # @param [AutodnsAPI::Transport] transport
    # @param [String] key of the attribute to query
    # @param [String] value of the attribute to query, can contain wildcards like *
    def self.all_by(transport, key, value)
      response = transport.request do |xml|
        xml.code '0304'
        xml.where do
          xml.key key.to_s
          xml.operator :like
          xml.value name.to_s
        end
      end
      
      Response.new(response)
    end
  end
end