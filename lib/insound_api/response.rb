require 'nokogiri'
require 'rest-client'

module InsoundApi
  class Response

    attr_reader :request, :raw_xml, :doc

    def initialize(opts={})
      @request = opts[:request]
      @raw_json = opts[:raw_xml]
    end

    # used by non-array returning responses
    def to_struct
      struct = struct_from_hash(json)
      struct.new(*deserialize_values(json))
    end

    # used by array returning resonses
    def to_a
      struct = nil
      self.json.map{|obj| 
        struct ||= struct_from_hash(obj)
        struct.new(*deserialize_values(obj))
      }
    end

    private

    def struct_from_hash(hash)
      attributes = hash.keys.map{|k|k.to_sym}
      Struct.new(*attributes)
    end

    def deserialize_values(hash)
      hash.values.map{|v| from_json(v) }
    end

    def from_xml(obj)
      if is_date?(obj)
        DateTime.strptime(obj, '%Y-%m-%dT%H:%M:%SZ')
      else
        obj
      end
    end

    def is_date?(obj)
      obj.is_a?(String) && obj =~ /\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z/i
    end

  end
end