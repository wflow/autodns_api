module AutodnsAPI
  class Response
    attr_reader :data
    
    def initialize(data)
      @data = data
    end

    # @return [Array<Hash>] of hashes
    def all_attributes
      @data.xpath('//result/data/*').map do |node|
        node.children.select(&:element?).inject({}) do |memo, element|
          memo[element.name] = element.text
          memo
        end
      end
      .reject(&:empty?)
    end

    # @return [Boolean]
    def success?
      @data.xpath('//status/type').text == 'success'
    end

    # @return [String]
    def status_message
      @data.xpath('//status/text').text
    end

    def status_object
      type  = @data.xpath('//status/object/type').text
      value = @data.xpath('//status/object/value').text

      {'type' => type, 'value' => value}
    end
  end
end