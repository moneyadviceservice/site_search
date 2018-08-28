module SiteSearch
  class Query
    attr_reader :query, :options, :adapter

    def initialize(query, options: {}, adapter: SiteSearch.config.adapter)
      @query = query
      @options = options
      @adapter = adapter
    end

    def results
      response = adapter.new(options).search(query)

      SiteSearch::Decorator.call(
        SiteSearch::Results.new(response)
      )
    end
  end
end
