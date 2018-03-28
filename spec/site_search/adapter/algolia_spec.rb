RSpec.describe SiteSearch::Adapter::Algolia do
  it_behaves_like 'an adapter'

  subject(:algolia) { described_class.new(options) }

  describe '#search' do
    let(:options) do
      {
        index: 'pages',
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

      # rubocop:disable Metrics/LineLength
      let(:results) do
        {
          results: [
            {
              title: '<br>Looking</br> <br>after</br> <br>your</br> <br>dependants</br> <br>in</br> <br>retirement</br>',
              description: 'How to make sure that <br>your</br> partner and/or children will be provided for when you retire.',
              link: '/en/articles/looking-after-your-dependants-in-retirement',
              raw: {
                title: 'Looking after your dependants in retirement',
                description: 'How to make sure that your partner and/or children will be provided for when you retire.'
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
      # rubocop:enable Metrics/LineLength

      it 'returns the highlighted results' do
        VCR.use_cassette('retirement_page', match_requests_on: [:body]) do
          expect(algolia.search(query)).to eq(results)
        end
      end
    end

    context 'when searching a page without highlight results' do
      let(:query) do
        'mortgages'
      end

      let(:result_without_description) do
        {
          title: '<br>Mortgages</br>',
          description: nil,
          link: '/en/categories/mortgages',
          raw: {
            title: 'Mortgages',
            description: nil
          }
        }
      end

      it 'returns the highlighted results' do
        VCR.use_cassette('mortgages', match_requests_on: [:body]) do
          expect(algolia.search(query)[:results].first)
            .to eq(result_without_description)
        end
      end
    end

    context 'when searching page with description but not highlighted' do
      let(:query) do
        'where free advice'
      end

      # rubocop:disable Metrics/LineLength
      let(:result_without_description) do
        {
          title:
            '<br>Where</br> to go to get <br>free</br> debt <br>advice</br>',
          description: "Free debt advice and help locator tool. Use our tool to find a debt advice service near you that's accredited by the Money Advice Service.",
          link: '/en/tools/debt-advice-locator',
          raw: {
            title: 'Where to go to get free debt advice',
            description: "Free debt advice and help locator tool. Use our tool to find a debt advice service near you that's accredited by the Money Advice Service."
          }
        }
      end
      # rubocop:enable Metrics/LineLength

      it 'returns the highlighted results' do
        VCR.use_cassette('debt_advice', match_requests_on: [:body]) do
          expect(algolia.search(query)[:results])
            .to include(result_without_description)
        end
      end
    end
  end
end
