require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Association test
  # ensure a comment record belongs to a single post record
  it { should belong_to(:post) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:commenter) }
end