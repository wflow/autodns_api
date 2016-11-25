require 'autodns_api/response'

module AutodnsAPI
  class Contact
    # @param [AutodnsAPI::Transport] transport
    # @param [String] name
    # @return [AutodnsAPI::Response]
    def self.all_by_name(transport, name='*')
      all_by(transport, :name, name)
    end

    # @param [AutodnsAPI::Transport] transport
    # @param [String] alias
    # @return [AutodnsAPI::Response]
    def self.all_by_alias(transport, an_alias='*')
      all_by(transport, :alias, an_alias)
    end

    # @param [AutodnsAPI::Transport] transport
    # @param [String] alias
    # @return [AutodnsAPI::Response]
    def self.by_id(transport, id)
      response = transport.request do |xml|
        xml.code '0304'
        xml.handle do
          xml.id id.to_s
        end
      end
      
      Response.new(response)
    end

    # @param [AutodnsAPI::Transport] transport
    # @param [String] key of the attribute to query
    # @param [String] value of the attribute to query, can contain wildcards like *
    # @return [AutodnsAPI::Response]
    def self.all_by(transport, key, value)
      response = transport.request do |xml|
        xml.code '0304'
        xml.where do
          xml.key key.to_s
          xml.operator :like
          xml.value value.to_s
        end
      end
      
      Response.new(response)
    end

    # Attention! This method takes all supplied params and sends them unchanged to the underlying xml object!
    # You have to validate the supplied attributes on your domain layer.
    # Usage:
    #    AutodnsAPI::Contact.create_handle(transport, type: 'PERSON', city: 'Trostberg', pcode: '83308', address: 'Gabelsbergerstr. 6', lname: 'Admin')
    #
    # @param [AutodnsAPI::Transport] transport
    # @param [Hash<Symbol,String>] params
    def self.create_handle(transport, params={})
      response = transport.request do |xml|
        xml.code '0301'
        xml.handle do
          params.each do |k, v|
            xml.send(k.to_sym, v.to_s)
          end
        end
      end
      
      Response.new(response)
    end
  end
end