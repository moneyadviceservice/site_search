RSpec.describe SiteSearch::Results do
  subject(:results) { described_class.new(response) }

  let(:response) do
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
  end

  describe '#collection' do
    it 'returns a collection from the search results' do
      expect(results.collection).to be_an(Array)
    end

    it 'returns a collection of SearchResult' do
      expect(results.collection.first).to be_a(SiteSearch::Result)
    end
  end

  describe '#page' do
    it 'returns page from the results' do
      expect(results.page).to be_zero
    end
  end

  describe '#total_results' do
    it 'returns total from the results' do
      expect(results.total_results).to be(1)
    end
  end

  describe '#per_page' do
    it 'returns per page from the results' do
      expect(results.per_page).to be(10)
    end
  end

  describe '#number_of_pages' do
    it 'returns number of pages from the results' do
      expect(results.number_of_pages).to be(1)
    end
  end

  describe '#query' do
    it 'returns query from the results' do
      expect(results.query).to eq('budget planner')
    end
  end
end
