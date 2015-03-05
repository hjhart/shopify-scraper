desc "Scrape all shopify app pages"
task :scrape => [:environment] do
  App.all.each { |app| app.update_reviews }
end
