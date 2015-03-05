require 'rails_helper'
require 'rake'
require 'webmock/rspec'

describe 'scrape' do
  before do
    load File.expand_path("../../../../lib/tasks/scrape.rake", __FILE__)
    Rake::Task.define_task(:environment)
  end

  let!(:app) { App.create(name: 'something', slug: 'something') }

  it "calls update_reviews on every app" do
    allow(App).to receive(:all) { [app] }
    expect(app).to receive(:update_reviews) { true }
    Rake::Task["scrape"].invoke
  end
end