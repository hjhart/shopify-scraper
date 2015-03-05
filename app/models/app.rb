require 'open-uri'

class App < ActiveRecord::Base
  validates_presence_of :slug, :name, :review_count

  def update_reviews
    number_of_reviews = parsed_html.css('meta[itemprop=reviewCount]').first['content']
    return true if number_of_reviews.to_i == review_count

    update_attributes(review_count: number_of_reviews.to_i)
    ReviewUpdater.perform(self.id)
  end

  def review_url(page=1)
    "https://apps.shopify.com/#{slug}?page=#{page}"
  end

  def parsed_html(page)
    html = open(review_url(page))
    Nokogiri::HTML(html)
  end
end
