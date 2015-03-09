require 'rails_helper'

describe ReviewUpdater do
  describe '.perform' do
    context 'when there are less than 10 reviews' do
      let(:app) { App.create(slug: 'power-tools-sort-orders', name: 'Power tools sort orders', review_count: 3) }
      it 'saves the reviews to the database' do
        VCR.use_cassette("three random reviews") do
          expect { ReviewUpdater.perform(app.id) }.to change(AppReview, :count).by(3)
        end
      end
    end

    context 'when there are more than 10 reviews' do
      let(:app) { App.create(slug: 'wanelo', name: 'Power tools sort orders', review_count: 20) }
      it 'paginates and saves the reviews' do
        VCR.use_cassette("wanelo two pages of reviews") do
          reviews = ReviewUpdater.perform(app.id)
          expect(app.app_reviews.count).to eq(20)
        end
      end
    end
  end
end