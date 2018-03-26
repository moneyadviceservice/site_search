module SiteSearch
  module Adapter
    class Local < Base
      def search(query)
        {
          results: [
            {
              title: '<em>Budget</em> <em>planner</em>',
              description: 'You can use this <em>planner</em>.',
              link: '/en/tools/budget-planner',
              raw: {
                title: 'Budget planner',
                description: 'You can use this planner'
              }
            }
          ],
          total_results: 1,
          page: 0,
          number_of_pages: 1,
          per_page: 10,
          query: query
        }
      end
    end
  end
end
