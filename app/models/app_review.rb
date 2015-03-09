class AppReview < ActiveRecord::Base
  belongs_to :app
  validates_presence_of :app, :body, :rating
end
