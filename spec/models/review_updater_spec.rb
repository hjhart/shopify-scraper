require 'rails_helper'

describe ReviewUpdater do
  describe '.perform' do
    context 'when there are less than 10 reviews' do
      let(:app) { App.create(slug: 'power-tools-sort-orders', name: 'Power tools sort orders', review_count: 3) }
      it 'returns json' do
        VCR.use_cassette("three random reviews") do
          expect(ReviewUpdater.perform(app.id)).to eq([
            {:id=>"20863", :published_date=>"2015-01-13T04:04:47-05:00", :body=>"Good.", :rating=>"5"},
            {:id=>"18145", :published_date=>"2014-10-14T05:17:15-04:00", :body=>"Very good!", :rating=>"5"},
            {:id=>"14944", :published_date=>"2014-06-16T00:18:20-04:00", :body=>"We used it successfully to run any type of product voting or contest for keeping your products in a random order for fair results. I'm sure there are many other possible use cases. Great support as well.", :rating=>"5"}
          ])
        end
      end
    end

    context 'when there are more than 10 reviews' do
      let(:app) { App.create(slug: 'wanelo', name: 'Power tools sort orders', review_count: 20) }
      it 'returns json' do
        VCR.use_cassette("wanelo two pages of reviews") do
          reviews = ReviewUpdater.perform(app.id)
          expect(reviews.size).to eq(20)
        end
      end
    end
  end
end