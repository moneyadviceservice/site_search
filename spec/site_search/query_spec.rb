RSpec.describe SiteSearch::Query do
  subject(:query) { described_class.new('query') }

  describe '#results' do
    it 'return results from adapter query' do
      expect(query.results).to be_an(SiteSearch::Results)
    end
  end
end
