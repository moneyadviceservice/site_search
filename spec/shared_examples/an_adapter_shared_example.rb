RSpec.shared_examples 'an adapter' do
  subject(:adapter) do
    described_class.new(options)
  end
  let(:options) { {} }

  describe '#options' do
    it 'responds to options' do
      expect(adapter).to respond_to(:options)
    end
  end

  describe '#search' do
    it 'responds to search' do
      expect(adapter).to respond_to(:search)
    end
  end
end
