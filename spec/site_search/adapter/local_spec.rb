RSpec.describe SiteSearch::Adapter::Local do
  it_behaves_like 'an adapter'
  subject(:adapter) { described_class.new({}) }

  describe '#search' do
    subject(:search) { adapter.search('budget planner') }

    it 'returns the results in the gem structure' do
      expect(search).to eq(
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
          query: 'budget planner'
        }
      )
    end
  end
end
