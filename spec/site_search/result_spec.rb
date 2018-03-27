RSpec.describe SiteSearch::Result do
  subject(:result) { described_class.new(response_result) }
  let(:response_result) do
    {
      title: '<em>Budget</em> <em>planner</em>',
      description: 'You can use this <em>planner</em>.',
      link: '/en/tools/budget-planner',
      raw: {
        title: 'Budget planner',
        description: 'You can use this planner'
      }
    }
  end

  describe '#title' do
    it 'returns title from response' do
      expect(result.title).to eq('<em>Budget</em> <em>planner</em>')
    end
  end

  describe '#description' do
    it 'returns description from response' do
      expect(result.description).to eq('You can use this <em>planner</em>.')
    end
  end

  describe '#link' do
    it 'returns link from response' do
      expect(result.link).to eq('/en/tools/budget-planner')
    end
  end

  describe '#raw' do
    it 'returns raw from response' do
      expect(result.raw).to eq(
        title: 'Budget planner',
        description: 'You can use this planner'
      )
    end
  end
end
