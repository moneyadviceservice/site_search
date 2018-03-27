module SiteSearch
  module Adapter
    class Algolia < Base
      def search(query)
        index = ::Algolia::Index.new(options.fetch(:index))

        logger.info("Searching '#{query} with: #{search_parameters}'")
        results = index.search(query, search_parameters)
        logger.info("Results:\n #{results}\n")

        to_hash(results)
      end

      private

      def search_parameters
        options.reject { |key, _| key.equal?(:index) }
      end

      def to_hash(response)
        {
          results: results_for(response),
          page: response['page'].to_i,
          query: response['query'].to_s,
          total_results: response['nbHits'].to_i,
          per_page: response['hitsPerPage'].to_i,
          number_of_pages: response['nbPages'].to_i
        }
      end

      def results_for(response)
        Array(response['hits']).map do |hit|
          highlight_result = hit['_highlightResult']

          {
            title: highlight_result['title']['value'],
            description: highlight_result['description']['value'],
            link: hit['objectID'],
            raw: {
              title: hit['title'],
              description: hit['description']
            }
          }
        end
      end
    end
  end
end
