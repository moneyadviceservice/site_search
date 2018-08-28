RSpec.describe SiteSearch::Decorator do
  subject { described_class.new(collection) }

  let(:collection) do
    instance_double(
      SiteSearch::Results,
      number_of_pages: 2,
      page: page
    )
  end
  let(:page) { 0 }

  describe '#page' do
    it 'returns the page offset by 1' do
      expect(subject.page).to eq(1)
    end
  end

  describe '#first_page?' do
    context 'when it is the first page' do
      it { expect(subject.first_page?).to eq(true) }
    end

    context 'when it is not the first page' do
      let(:page) { 1 }

      it { expect(subject.first_page?).to eq(false) }
    end
  end

  describe '#last_page?' do
    context 'when it is the last page' do
      let(:page) { 1 }

      it { expect(subject.last_page?).to eq(true) }
    end

    context 'when it is not the last page' do
      it { expect(subject.last_page?).to eq(false) }
    end
  end

  describe '#previous_page' do
    context 'when there is a previous page' do
      let(:page) { 1 }

      it { expect(subject.previous_page).to eq(0) }
    end

    context 'when there is not a previous page' do
      it { expect(subject.previous_page).to eq(nil) }
    end
  end

  describe '#next_page' do
    context 'when there is a next page' do
      it { expect(subject.next_page).to eq(1) }
    end

    context 'when there is not a next page' do
      let(:page) { 1 }

      it { expect(subject.next_page).to eq(nil) }
    end
  end
end
