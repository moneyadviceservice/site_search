RSpec.describe SiteSearch::Query do
  subject(:query) do
    described_class.new('query', options: options, adapter: adapter)
  end

  let(:options) { { index: 'pages' } }
  let(:adapter) { double(SiteSearch::Adapter::Local) }

  describe '#results' do
    let(:response) { { results: [] } }
    let(:instance) do
      instance_double(SiteSearch::Adapter::Local, search: response)
    end
    let(:results) { instance_double(SiteSearch::Results) }

    before { allow(adapter).to receive(:new).and_return(instance) }

    it 'returns results from adapter query' do
      expect(query.results).to be_an(SiteSearch::Decorator)
    end

    it 'queries the adapter with the given query', :aggregate_failures do
      expect(adapter).to receive(:new).with(options)
      expect(instance).to receive(:search).with('query')

      query.results
    end

    it 'returns a decorated instance of results', :aggregate_failures do
      expect(SiteSearch::Results).to receive(:new)
        .with(response)
        .and_return(results)
      expect(SiteSearch::Decorator).to receive(:new)
        .with(results)

      query.results
    end
  end
end
