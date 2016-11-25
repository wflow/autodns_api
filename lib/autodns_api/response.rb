module AutodnsAPI
  class Response
    attr_reader :data
    
    def initialize(data)
      @data = data
    end

    def attributes
      @data.xpath('//result/data/*').map do |node|
        node.children.select(&:element?).inject({}) do |memo, element|
          memo[element.name] = element.text
          memo
        end
      end
    end
    
    def success?
      @data.xpath('//status/type').text == 'success'
    end
  end
end