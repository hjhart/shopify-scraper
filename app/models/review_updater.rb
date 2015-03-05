class ReviewPaginator
  def self.perform(app)
    page = 1
    reviews = []
    while (reviews.size < app.review_count)
      parsed = app.parsed_html(page)
      reviews = reviews + parsed.css('figure[itemprop=review]').map { |review_html| ReviewExtractor.new(review_html).as_json }
      page += 1
    end
    reviews
  end
end

class ReviewExtractor < Struct.new(:review_html)
  def as_json(options = nil)
    id = review_html['data-review_id']
    published_date = review_html.at_css('meta[itemprop=datePublished]')['content']
    body = review_html.at_css('[itemprop=reviewBody]').text
    rating = review_html.at_css('[itemprop=reviewRating]')['content']

    {
      id: id,
      published_date: published_date,
      body: body,
      rating: rating
    }
  end
end

class ReviewUpdater
  def self.perform(app_id)
    app = App.find(app_id)
    reviews = ReviewPaginator.perform(app)
  end
end