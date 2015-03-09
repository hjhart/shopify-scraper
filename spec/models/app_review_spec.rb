require 'rails_helper'

RSpec.describe AppReview, type: :model do
  it { should belong_to :app }
  it { should validate_presence_of :app }
  it { should validate_presence_of :body }
  it { should validate_presence_of :rating }
end
