module SiteSearch
  module Adapter
    class Base
      attr_reader :options, :logger

      def initialize(options)
        @options = options
        @logger = SiteSearch.config.logger
      end

      def search(query)
        raise NotImplementedError
      end
    end
  end
end
