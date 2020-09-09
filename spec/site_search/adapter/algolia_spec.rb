RSpec.describe SiteSearch::Adapter::Algolia do
  it_behaves_like 'an adapter'

  subject(:algolia) { described_class.new(options) }

  describe '#search' do
    let(:options) do
      {
        index: 'uat_money_advice_service',
        highlightPreTag: '<br>',
        highlightPostTag: '</br>',
        page: 0,
        hitsPerPage: 10
      }
    end

    context 'when returning empty response' do
      let(:query) do
        'query'
      end

      let(:results) do
        {
          results: [],
          page: 0,
          query: '',
          total_results: 0,
          per_page: 0,
          number_of_pages: 0
        }
      end

      it 'sends all options on the search' do
        expect_any_instance_of(::Algolia::Index).to receive(:search).with(
          query,
          highlightPreTag: '<br>',
          highlightPostTag: '</br>',
          hitsPerPage: 10,
          page: 0
        ).and_return({})
        expect(algolia.search(query)).to eq(results)
      end
    end

    context 'when searching a non existent page' do
      let(:query) do
        'algoliaaaaaaaaaaaaaaaaaa'
      end

      let(:results) do
        {
          results: [],
          page: 0,
          query: query,
          total_results: 0,
          per_page: 10,
          number_of_pages: 0
        }
      end

      it 'returns empty results' do
        VCR.use_cassette('non_existent_page', match_requests_on: [:body]) do
          expect(algolia.search(query)).to eq(results)
        end
      end
    end

    context 'when searching an existent page' do
      let(:query) do
        'Looking after your dependants in retirement'
      end

      it 'returns the expected results' do
        VCR.use_cassette('retirement_page', match_requests_on: [:body]) do

          expect(algolia.search(query)).to include(:results => array_including(hash_including(:title, :link, :description)))
        end
      end
    end
  end
end
