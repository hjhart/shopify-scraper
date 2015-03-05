class App < ActiveRecord::Base
  validates_presence_of :slug, :name, :review_count
end
