class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :review_count, null: false, default: 0
      t.integer :rating_value
      t.integer :worst_rating
      t.integer :best_rating
      t.string :description
      t.timestamps null: false
    end
  end
end
