class CreateAppReviews < ActiveRecord::Migration
  def change
    create_table :app_reviews do |t|
      t.integer :app_id
      t.integer :review_id
      t.datetime :published_at
      t.text :body
      t.integer :rating

      t.timestamps null: false
    end
  end
end
