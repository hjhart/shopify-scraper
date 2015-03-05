require 'rails_helper'

RSpec.describe App, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :slug }
  it { should validate_presence_of :review_count }

  describe '#update_reviews' do
    let!(:app) { App.create(name: 'Wanelo App', slug: 'wanelo', review_count: 20) }
    context 'when the number of reviews are the same' do
      it 'returns true' do
        VCR.use_cassette("twenty_wanelo_reviews") do
          expect {
            expect(app.update_reviews).to eq(true)
          }.not_to change(app, :review_count)
        end
      end
    end

    context 'when the number of reviews are different' do
      let!(:app) { App.create(name: 'Wanelo App', slug: 'wanelo', review_count: 19) }
      it 'updates the review count' do
        VCR.use_cassette("twenty_wanelo_reviews") do
          expect {
            app.update_reviews
          }.to change(app, :review_count).from(19).to(20)
        end
      end

      it 'calls the ReviewUpdater' do
        VCR.use_cassette("twenty_wanelo_reviews") do
          expect(ReviewUpdater).to receive(:perform).with(app.id)
          app.update_reviews
        end
      end
    end
  end

  describe '#review_url' do
    let(:app) { App.new(slug: 'james-butts')}

    it 'constructs off of the slug' do
      expect(app.review_url).to eq('https://apps.shopify.com/james-butts?page=1')
    end

    it 'takes a page parameter' do
      expect(app.review_url(3)).to eq('https://apps.shopify.com/james-butts?page=3')
    end
  end
end
