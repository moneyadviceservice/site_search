module SiteSearch
  class Config
    attr_accessor :adapter, :logger

    def adapter
      adapter_name = @adapter || 'local'
      SiteSearch::Adapter.const_get(adapter_name.capitalize)
    end

    def logger
      @logger || ::Logger.new(STDOUT)
    end
  end
end
