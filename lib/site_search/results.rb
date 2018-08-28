require 'delegate'

module SiteSearch
  class Results
    attr_reader :response,
                :page,
                :per_page,
                :total_results,
                :number_of_pages,
                :query,
                :collection

    def initialize(response)
      @response = response
      @page = response[:page]
      @per_page = response[:per_page]
      @total_results = response[:total_results]
      @number_of_pages = response[:number_of_pages]
      @query = response[:query]

      @collection = @response[:results].map do |response_result|
        ::SiteSearch::Result.new(response_result)
      end
    end
  end
end
