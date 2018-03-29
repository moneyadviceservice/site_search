RSpec.describe SiteSearch::Config do
  describe '#adapter' do
    it 'returns local adapter as default' do
      expect(subject.adapter).to be(SiteSearch::Adapter::Local)
    end

    it 'overides default adapter' do
      subject.adapter = :algolia
      expect(subject.adapter).to be(SiteSearch::Adapter::Algolia)
    end
  end

  describe '#logger' do
    context 'when logger is setup' do
      let(:logger) { double('logger') }

      it 'returns logger' do
        subject.logger = logger
        expect(subject.logger).to be(logger)
      end
    end

    context 'when logger is not setup' do
      it 'returns default logger' do
        expect(subject.logger).to be_a(::Logger)
      end
    end
  end
end
