module AutodnsAPI
  class Domain
    # @param [AutodnsAPI::Transport] transport
    # @param [String] name
    # @return [AutodnsAPI::Response]
    def self.all_by_name(transport, name='*')
      all_by(transport, :name, name)
    end

    # @param [AutodnsAPI::Transport] transport
    # @param [String] name
    # @return [AutodnsAPI::Response]
    def self.by_name(transport, name)
      response = transport.request do |xml|
        xml.code '0105'
        xml.domain do
          xml.name name.to_s
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
        xml.code '0105'
        xml.where do
          xml.key key.to_s
          xml.operator :like
          xml.value value.to_s
        end
      end
      
      Response.new(response)
    end
  end
end