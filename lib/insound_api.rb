module InsoundApi
  autoload :Config, 'insound_api/config'
  autoload :Request, 'insound_api/request'
  autoload :Query, 'insound_api/query'
  autoload :Results, 'insound_api/results'
  autoload :RequestException, 'insound_api/request'
  autoload :Response, 'insound_api/response'

  autoload :ObjectBase, 'insound_api/object_base'
  autoload :Product, 'insound_api/product'
  autoload :Artist, 'insound_api/artist'


  class ConfigException < Exception
    EXCEPTION_TEXT = <<-eos
    You must setup InsoundApi before you can use!  Ex:

    InsoundApi.setup do |config|
      config.affiliate_id = 2343234
      config.api_password = 'aklsdfjlksdajflks'
    end
eos
  end

  def self.config
    if @config
      @config
    else
      raise ConfigException, ConfigException::EXCEPTION_TEXT
    end
  end

  def self.setup(&block)
    @config = Config.new
    yield @config
  end
end
